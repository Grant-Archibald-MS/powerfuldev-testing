# Powerful Dev Conference 2025 - Proposed Testing Session

To help tailor the submission we are Crowd sourcing submission for Powerful Dev Conference 2025. We’d love to hear your thoughts and suggestions! What specific challenges have you faced with automated testing in the Power Platform? Are there particular topics or examples you’d like us to cover? Your feedback will help shape a session that truly meets the needs of our community. Let’s collaborate to make this session as impactful and relevant as possible! 🚀

## Important Note on Early Development Features

Please be aware that this session relates to a build-from-source strategy with features that are no yest released as part of the Power Apps Test Engine. Specific features or concepts discussed in this session and reposotory still need to be reviewed and approved before they will be included as features available as part of the `pac test run` Power Platform Command Line Interface. This means that some features are experimental and subject to change. 

We encourage you to provide feedback and suggestions to help shape these features as they progress towards stable releases. Your input is invaluable in ensuring that the final implementations meet the needs of the community and adhere to best practices.

## Proposed Session

![Powerful Dev Conference](./media/PowerfulDevConference.png)

**Session Due:** October 30

**Session Status:** Submitted

## How to contribute and keep up to date:

Comment on [Linked In](https://www.linkedin.com/pulse/powerful-devs-conference-low-code-testing-grant-archibald-xwjac/) with your thoughts. 

You can also you your GitHub account to login then use the notification and star buttons to watch the repository and give feedback if these topics are important to you and your organization.

## Session Title

Mastering Automated Testing in Power Platform: From Unit Tests to CI/CD Integration

## Presenter

[Grant Archibald](https://www.linkedin.com/in/grantarchibald/) - Collaborator and Contributor to Test Engine

Microsoft Program Manager

Power CAT Engineering

## Abstract

Join us at the Powerful Devs Conference 2025 for an in-depth session on automated testing within the Power Platform. This session will address the common challenges of automated testing in projects and provide valuable insights into pragmatic approaches for testing and monitoring both low-code and pro-code solutions. Learn how to build robust applications, flows, and Copilot solutions with comprehensive unit and integration tests. Discover how to integrate quality and review gates into your CI/CD process, perform operational checks, and validate system dependencies. We will also explore how to apply engineering excellence principles to both code-first and low-code development.

## Possible Topics

Topics that could be discussed include:
1. Building Apps, Flows, and Copilot with Unit/Integration Tests: Learn how to create and implement unit and integration tests for your Power Apps, Power Automate flows, and Copilot solutions.

2. Integrating Quality and Review Gates in CI/CD: Understand how to build in quality and review gates that fit seamlessly with your CI/CD process.

3. Operational Checks and System Validation: Explore methods for performing operational checks and validating system dependencies to ensure reliability.

4. Engineering Excellence for Code-First and Low-Code Makers: Apply engineering excellence principles to enhance the quality and maintainability of your solutions.

5. Real-World Examples from the CoE Kit: Gain insights from real-world examples of automating the installation and testing of various Power Apps, Power Automate, Dataverse, and AI components within the CoE Kit.

 

## Tell Me More

| Preview | Link |
|---------|------|
| <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="50" height="50"> | [Power Apps Test Engine - GitHub Repo](https://github.com/microsoft/PowerApps-TestEngine) with open source implementation of Power Apps Test Engine
| <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="50" height="50"> | [Guidance Documentation](https://github.com/microsoft/PowerApps-TestEngine/blob/grant-archibald-ms/docs/docs/README.md) available as markdown files in the GitHub repository.
| <img src="https://learn.microsoft.com/en-us/power-platform/guidance/coe/media/coesetupwizard.png" width="200px" /> | [Example - CoE Starter Kit Setup and Upgrade Wizard](./examples/coe-kit-setup-and-install-wizard.md) discusses using Power Apps Test Engine to test custom page of Model Driven Application
| <img src="./examples/media/powerfx+csharp.png" width="200"/> | [Example - Extending Power FX test with C# test scripts](./examples/extending-testengine-powerfx-with-with-csharp-test-scripts.md) Discusses using C# script to extend Power Apps Test Engine
| <img src="./examples/media/custom-page-variables-collections.png" width="200"/> | [Example - Testing Variables and Collections in Power Apps with the Test Engine](./examples/custom-page-variables-and-collections.md) to simplify and control the state of a Power App testing.
| <img src="https://learn.microsoft.com/power-apps/maker/canvas-apps/media/connections-list/power_apps_consent_dialog.png" width="200px"/> | Example of ["no-cliffs" extensibility model](./examples/understanding-no-cliffs-extensibility-model.md) of Test Engine using Power Apps Consent Dialog as an example using Power FX and C# together.
| <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="50" height="50"> | [Build from source](./examples/coe-kit-build-from-source-run-tests.md) example for the CoE Kit to run tests with new features
| <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="50" height="50"> | [Extending the Test Engine to Support Testing of the CoE Starter Kit Setup and Upgrade Wizard](./examples/coe-kit-extending-test-engine.md) provides examples for the CoE Kit when building and testing different steps of the install process.
| <img src="./examples/media/coe-kit-testing-layers.png" width="200"/> | [Example - Executing CoE Starter Kit Test Automation](./examples/coe-kit-automate-test-sample.md) to understand the wider context of automated tests and specific tests for the Power Apps based Setup and Upgrade Wizard.
| <img src="./examples/media/coe-kit-power-platform-alm-support-lifecycle-example.png" width="200"/> | [Example - CoE Starter Kit Test Automation ALM](./examples/coe-kit-test-automation-alm.md) used the ALM process for the CoE Starter Kit to look at options to author and execute tests as part of a continuous integration and deployment process.
| <img src="./examples/media/coe-kit-infrastructure-as-code.png" width="200"/> | [Example - CoE Starter Kit Infrastructure as Code](./examples/coe-kit-infrastructure-as-code.md) uses and infrastructure as code approach to provision, deploy and test an instance of CoE Starter Kit.
| <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="50" height="50"> | [Using Power Fx Namespaces in Testing](./examples/using-powerfx-namespaces-in-testing.md) discussion on using namespaces in test steps to help organize Power Fx functions available.