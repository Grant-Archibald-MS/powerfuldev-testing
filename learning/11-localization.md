# Localization

## Introduction

In this section, we will investigate the testing of a localized Weather sample. Localization is the process of adapting an application to meet the language, cultural, and other requirements of a specific target market. The ability to support multiple languages in your application can make it more accessible and user-friendly for a global audience.

## The Need for Localization

Localization is essential for several reasons:
- **User Experience**: Providing content in the user's native language enhances their experience and makes the application more intuitive.
- **Market Reach**: Localizing your application allows you to reach a broader audience and tap into new markets.
- **Compliance**: In some regions, providing content in the local language is a legal requirement.

## Testing Localized Applications

When testing localized applications, it is important to ensure that all elements of the application are correctly translated and formatted. This includes text, dates, numbers, and other locale-specific content. Additionally, you should verify that the application behaves as expected in different languages and regions.

## Power Platform Localization

The Power Platform provides robust support for localization in both Canvas and Model-Driven Applications. You can find detailed information on how to localize your Power Apps applications in the following resources:

1. [Translate text for model-driven apps](https://learn.microsoft.com/power-apps/maker/model-driven-apps/translate-localizable-text)
2. [Build a multi-language app](https://learn.microsoft.com/power-apps/maker/canvas-apps/multi-language-apps)
3. [Add Localized Titles for Navigation Groups](https://learn.microsoft.com/power-apps/maker/model-driven-apps/app-navigation#create-a-group)
4. [Regional and language options for your environment](https://learn.microsoft.com/power-platform/admin/enable-languages#enable-the-language). This section assumes that Franch language (LCID 1039) has been enabled.

## Example: Localizing the Weather Sample

To explore different languages using the Weather sample, follow these steps to expand from English Version

{% include figure popup=true image_path="/learning/media/weather-snaphots.png" alt="Example English version of the weather snap shots application" %}

And French version

{% include figure popup=true image_path="/learning/media/cliches-meteorologiques.png" alt="Example French version of the weather snap shots application" %}

To include German version of the same application

{% include figure popup=true image_path="/learning/media/wetterschnappschusse.png" alt="Example French version of the weather snap shots application" %}

### Step 1: Start the Application

Start the Weather Application imported in [Using Simulations](./10-using-simulations.md).

### Step 2: Change Personal Settings

To change the user interface language, follow these steps:
1. Open the Power Apps portal.
2. Navigate to **Settings** (gear icon) > **Languages**.
3. Under **User Interface Language**, select **French**.
4. Save the changes and refresh the application.

### Step 3: Verify Language Change

The controls of the custom page should change using the `Language()` Power Fx function. For example, the labels and buttons should now display in French.

### Step 4: Automate Language Change with Repost.ps1

The `Repost.ps1` file makes use of the Dataverse API to update the [usersettingscollection](https://learn.microsoft.com/power-apps/developer/data-platform/reference/entities/usersettings) and automate the process of changing the [UI language](https://learn.microsoft.com/power-apps/developer/data-platform/reference/entities/usersettings#BKMK_UILanguageId). This script can be used to switch between languages programmatically.

### Step 5: Expand to Another Language

#### Model Driven Application Changes

To expand the example to another language, such as German (LCID 1031), follow these steps:
1. Export the translations and add a new column for German (1031). The [Translate customized table, form, and column text into other languages](https://learn.microsoft.com/power-apps/maker/data-platform/export-customized-entity-field-text-translation)
2. Update the translation file with the German translations.
3. Rezip the file and import the translations.

#### Model Driven Application Navigation Changes 
1. Edit the `Weather Snapshots` Model Driven Application
2. Change the advanced settings of the navigation group to include German. For example [Add Localized Titles for Navigation Groups](https://learn.microsoft.com/power-apps/maker/model-driven-apps/app-navigation#create-a-group)
3. Publish the changes to the Model Driven Application to apply group name changes.

#### Component Library Changes

1. Select `Localization` from solution Component libraries

2. Edit the `Localization` item

3. Update the component Power Fx to add "de-de" for the localization code library `Labels` of the "Translation Component" to include Table with Language "de-de". For example the original Labels could look like

    ```powerfx
    LookUp(Table(
            {
                Language: "en-us",
                Labels: {
                    LocationLabel: "Location",
                    Category: "Category",
                    MetricLabel: "Metric",
                    ImperialLabel: "Imperial",
                    SearchLabel: "Search",
                    AddLabel: "Add",
                    MatchLabel: "Match: ",
                    TempLabel: "Temp: ",
                    FeelsLabel: "Feels: "
                }
            },
            {
                Language: "fr-fr",
                Labels: {
                    LocationLabel: "Emplacement",
                    Category: "Catégorie",
                    MetricLabel: "Métrique",
                    ImperialLabel: "Impérial",
                    SearchLabel: "Recherche",
                    AddLabel: "Ajouter",
                    MatchLabel: "Correspondance: ",
                    TempLabel: "Température: ",
                    FeelsLabel: "Ressenti: "
                }
            }
        ),Language = Lower(
    Language()
    )).Labels
    ```

    After applying changes new translations could look like

    ```powerfx
    LookUp(
        Table(
            {
                Language: "en-us",
                Labels: {
                    LocationLabel: "Location",
                    Category: "Category",
                    MetricLabel: "Metric",
                    ImperialLabel: "Imperial",
                    SearchLabel: "Search",
                    AddLabel: "Add",
                    MatchLabel: "Match: ",
                    TempLabel: "Temp: ",
                    FeelsLabel: "Feels: "
                }
            },
            {
                Language: "fr-fr",
                Labels: {
                    LocationLabel: "Emplacement",
                    Category: "Catégorie",
                    MetricLabel: "Métrique",
                    ImperialLabel: "Impérial",
                    SearchLabel: "Recherche",
                    AddLabel: "Ajouter",
                    MatchLabel: "Correspondance: ",
                    TempLabel: "Température: ",
                    FeelsLabel: "Ressenti: "
                }
            },
            {
                Language: "de-de",
                Labels: {
                    LocationLabel: "Ort",
                    Category: "Kategorie",
                    MetricLabel: "Metrisch",
                    ImperialLabel: "Imperial",
                    SearchLabel: "Suche",
                    AddLabel: "Hinzufügen",
                    MatchLabel: "Übereinstimmung: ",
                    TempLabel: "Temperatur: ",
                    FeelsLabel: "Gefühlt: "
                }
            }
        ),
        Language = Lower(Language())
    ).Labels
    ```

4. Publish the update components.
5. Select the `Snapshots`custom page from pages of the solution
6. Select Edit for the Snapshots custom page
7. After the page of the model driven application opens, review the change and confirm update and refresh the page with the new published component.
8. Save the changes to the custom page
9. Publish the new version of the custom page

Once you have completed these changes you should be able to use English, French and German translations of the Weather Application.

## Summary

In this section, you learned about the importance of localization and how to test a localized Weather sample. Localization can be crucial for enhancing user experience, expanding market reach, and complying with regional requirements. The Power Platform provides robust support for localization in both Canvas and Model-Driven Applications.

You explored how to start the Weather application, change personal settings to switch the user interface language, and verify the language change using the Language() Power Fx function. Additionally, you learned how to automate the language change process using the Repost.ps1 script and the Dataverse API.

To expand the example to another language, such as German, you followed steps to export translations, update the translation file, and import the translations. You also learned how to update the navigation group settings and component library to include the new language.

By following these steps, you can ensure that your Power Apps application supports multiple languages, making it more accessible and user-friendly for a global audience.
