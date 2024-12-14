---
layout: single
title: Latest Posts
permalink: /latest
toc: true
sidebar:
  nav: "docs"
---

We are excited to share our latest updates and insights with you. Please check back regularly for new content and updates. We hope you find our posts informative and engaging.

<ul>
  {% for post in site.posts %}
    <li>
      <a href="/powerfuldev-testing{{ post.url }}">{{ post.title }}</a>
      <span>{{ post.date | date: "%B %d, %Y" }}</span>
      <p>{{ post.excerpt | strip_html | truncatewords: 20 }}</p>
    </li>
  {% endfor %}
</ul>