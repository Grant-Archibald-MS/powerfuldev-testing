# Software Engineers

Welcome to the section dedicated to Software Engineers! Here, we'll explore the roles and responsibilities of software engineers in the low-code testing landscape on the Power Platform. Let's dive into their interests, oversight, and the importance of automated testing.

## Interests and Oversight

As a Software Engineer, your primary focus is on leveraging your code-first skills to enhance and extend the capabilities of the Power Platform. You play a crucial role in integrating traditional development practices with low-code solutions, ensuring that both approaches work seamlessly together. Your responsibilities include:

- **Augmenting Productivity**: Using the Power Platform to boost your productivity by creating custom solutions, automating tasks, and streamlining workflows.
- **Contributing Extensions**: Developing extensions or add-ons that help makers achieve more with the Power Platform, providing them with additional functionality and capabilities.
- **Ensuring Quality**: Implementing best practices for development, testing, and deployment to ensure that low-code solutions are robust, reliable, and meet the required standards.

Your oversight extends to ensuring that the Power Platform solutions are integrated with existing IT systems and processes, providing a cohesive approach to both low-code and code-first development.

## The Need for Automated Testing

Automated testing is a vital tool for Software Engineers. It helps in:

- **Efficiency**: Automated tests can be run quickly and repeatedly, saving time and reducing the manual effort required for testing.
- **Consistency**: Automated tests provide consistent results, reducing the risk of human error and ensuring that tests are performed the same way every time.
- **Early Detection**: Automated tests can catch issues early in the development process, allowing for quicker fixes and reducing the impact on the final product.
- **Scalability**: Automated testing can easily scale to accommodate larger projects and more complex testing scenarios, making it an essential tool for Software Engineers.

By embracing automated testing, you can ensure that the Power Platform solutions are robust, reliable, and ready for deployment. This not only enhances the quality of the solutions but also contributes to the overall success of the organization.

## Discussions

The following [discussions](../discussion/) could be of interest

| Discussion | Description |
|------------|-------------|
[Low Code Power Platform Testing for the Code First Developer](https://github.com/Grant-Archibald-MS/powerfuldev-testing/blob/main/discussion/low-code-testing-for-code-first-developer.md) | This article is intended as a starter for discussion and contains content that is under development. It is based on experiences from teams like the Power CAT Engineering team as they apply low code testing principles to the low code Power Platform solutions they build and maintain. Ideally, this discussion serves as a great starting point to foster collaboration and gain input to help shape low code automation and engineering excellence in the wider low code Power Platform community. | [Link](https://github.com/Grant-Archibald-MS/powerfuldev-testing/issues/2)
[Playwright vs Power Apps Test Engine](https://github.com/Grant-Archibald-MS/powerfuldev-testing/blob/main/discussion/playwright-vs-test-engine.md) | When it comes to testing low-code Power Platform applications, a common question arises: why not just use Playwright to directly test a Power App rather than using the Power Apps Test Engine? This discussion aims to explore the strengths and limitations of both tools and provide insights into their best use cases. | [Link](https://github.com/Grant-Archibald-MS/powerfuldev-testing/issues/1)
| [Authentication in Power Apps Test Engine](https://github.com/Grant-Archibald-MS/powerfuldev-testing/blob/main/discussion/authentication.md) | Authentication is a critical component of the test automation process. The sample script employs browser-based authentication, which offers a range of options to authenticate with Microsoft Entra. This method generates a persistent browser cookie, allowing for non-interactive execution of subsequent tests. The management of these browser cookies is governed by the guidelines provided in the Microsoft Entra documentation on session lifetime and conditional access policies. |[Link](https://github.com/Grant-Archibald-MS/powerfuldev-testing/issues/8)
| [Data Simulation](https://github.com/Grant-Archibald-MS/powerfuldev-testing/blob/main/discussion/data-simulation.md) | This discussion aims to explore the concepts of data simulation and mocking in the context of low code solutions, particularly focusing on Power Fx commands for Dataverse calls, connectors, and workflows. | [Link](https://github.com/Grant-Archibald-MS/powerfuldev-testing/issues/9)
| [Does Every Solution Need Automated Testing?](../discussion//does-every-solution-need-automated-testing.md) | Automated testing, with its promise of efficiency and reliability, has become a cornerstone of modern development practices. However, the necessity and extent of its application can vary significantly depending on the context and nature of the project. | |
| [Test Authoring](https://github.com/Grant-Archibald-MS/powerfuldev-testing/blob/main/discussion/test-authoring.md) | In this discussion, we will explore the overview of authoring test cases using the Test Engine. We will delve into various aspects such as the CoE Kit Test Case Authoring, discoverability of visual elements, Test Studio, and the settings and configurations of the Test Engine. Additionally, we will discuss the role of Generative AI in enhancing the test authoring process. | [Link](https://github.com/Grant-Archibald-MS/powerfuldev-testing/issues/11)

## Examples

The following [examples](../examples/) could be of interest

| Example | Description |
|---------|-------------|
| [Extending TestEngine Power FX with C# Test Scripts](../examples/extending-testengine-powerfx-with-with-csharp-test-scripts.md) | The extensibility of TestEngine Power FX using C# test scripts allows developers to integrate web-based Playwright commands through code-first extensibility, enhancing browser automation capabilities. This approach enables the creation of custom test scripts that leverage Playwright's powerful features, improving productivity and maintainability by focusing on high-level test logic while handling common code efficiently
| [Understanding the "No Cliffs" Extensibility Model of Power Apps Test Engine](../examples/understanding-no-cliffs-extensibility-model.md) | The "no cliffs" extensibility model of Power Apps Test Engine ensures that users can extend its capabilities without encountering barriers, providing a seamless experience for both makers and developers. By leveraging Power FX and C# test scripts, this model simplifies handling complex scenarios like Power Apps consent dialogs to enhancing the efficiency and reliability of the testing process
| [Testing Variables and Collections in Power Apps with the Test Engine](../examples/custom-page-variables-and-collections.md) | The Test Engine in Power Apps offers robust capabilities for testing variables and collections, simplifying application state management. By leveraging the Set() function, developers can directly change the state of the application, making it easier to verify functionality and handle various scenarios.
