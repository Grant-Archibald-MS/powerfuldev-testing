const fs = require('fs');
const path = require('path');
const glob = require('glob');
const spellchecker = require('spellchecker');
const frontMatter = require('front-matter');
const MarkdownIt = require('markdown-it');

const md = new MarkdownIt();

function readLinesFromFile(fileName) {
    return fs.readFileSync(fileName, 'utf-8').split('\n').map(line => line.trim());
}

function removePunctuation(text) {
    return text.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g, ' ');
}

function checkSpelling(text, skipWords) {
    const words = text.split(/\s+/);
    const misspelled = words.filter(word => !skipWords.includes(word) && spellchecker.isMisspelled(word));
    if (misspelled.length > 0) {
        return misspelled.map(word => {
            const suggestions = spellchecker.getCorrectionsForMisspelling(word);
            return `Misspelled word: ${word}. Suggestions: ${suggestions.join(', ')}`;
        });
    }
    return [];
}

function preprocessMarkdown(content) {
    return content
        .replace(/\[([^\]]+)\]\([^\)]+\)/g, '$1') // Remove markdown links
        .replace(/{%[^%]+%}/g, '') // Remove text inside {% %}
        .replace(/`[^`]+`/g, '') // Remove text inside backticks
        .replace(/<[^>]+>([^<]+)<\/[^>]+>/g, '$1') // Remove embedded HTML blocks
        .replace(/<[^>]+\/>/g, '') // Remove self-closed tags
        .replace(/https?:\/\/[^\s]+/g, ''); // Remove URLs
}

function spellCheckMarkdownFiles(directories, skipWords) {
    directories.forEach(directory => {
        const absoluteDirectory = path.resolve(__dirname, directory);
        const markdownFiles = glob.sync(path.join(absoluteDirectory, '**/*.md').replace(/\\/g, '/'));
        markdownFiles.forEach(filePath => {
            const content = fs.readFileSync(filePath, 'utf-8');
            const post = frontMatter(content);

            let errors = [];

            // Check spelling in front matter values, excluding image attributes
            Object.entries(post.attributes).forEach(([key, value]) => {
                if (!key.toLowerCase().includes('image')) {
                    errors = errors.concat(checkSpelling(removePunctuation(String(value)), skipWords));
                }
            });

            // Preprocess and check spelling in the rest of the content
            const preprocessedContent = preprocessMarkdown(post.body);
            const tokens = md.parse(preprocessedContent, {});
            tokens.forEach(token => {
                if (['heading_open', 'paragraph_open', 'table_open', 'inline'].includes(token.type)) {
                    errors = errors.concat(checkSpelling(removePunctuation(token.content), skipWords));
                }
                if (token.type === 'link_open' || token.type === 'image') {
                    const linkText = token.children.find(child => child.type === 'text');
                    if (linkText) {
                        errors = errors.concat(checkSpelling(removePunctuation(linkText.content), skipWords));
                    }
                }
                if (token.type === 'html_block') {
                    errors = errors.concat(checkSpelling(removePunctuation(token.content), skipWords));
                }
                if (token.type === 'fence') {
                    // Skip spell-checking code blocks
                    return;
                }
            });

            if (errors.length > 0) {
                console.log(`========= ${filePath} ====================`);
                errors.forEach(error => console.log(error));
            }
        });
    });
}

const scriptDir = path.dirname(__filename);
const directoriesFile = path.join(scriptDir, 'directories.txt');
const skipWordsFile = path.join(scriptDir, 'skip.txt');

const directories = readLinesFromFile(directoriesFile);
const skipWords = readLinesFromFile(skipWordsFile);

spellCheckMarkdownFiles(directories, skipWords);