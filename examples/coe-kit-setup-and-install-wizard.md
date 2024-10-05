# Example: CoE Kit Setup and Install Wizard

## Use Case Example

Once example we have been working on recently is Automated testing of the [Setup and Wizard](https://learn.microsoft.com/power-platform/guidance/coe/setup-core-components) as we considered Automated Test for this application we had to look the following.

1. How do we collaborate with the Test Engine team to improve the Test Engine?
2. How do we setup and install the solution?
3. Could we automate the creation of the environment, install of dependancies, setup of connections?
4. How we extend testing a Model Driven Application with custom pages?
5. How do we handle the user consent diaglog?
6. How build tests to interact with a complicated multi stage setup process?
7. How can we craete integration tests calling Power Automate Cloud Flows?
8. How can we validating the successful setup and state with dataverse?
9. How can we scale what we are learning to improve guidance?

## Early Adopter and Build from Source

We collaborated closely with the Test Engine team by contributing code to the repository. This included adding new code for authentication, providers for the Model Driven app, and expanding Power Fx functions to make testing easier. By building the open source from code, we applied a build process to integrate tests as part of our deployment process. This ensured that our tests were consistently run and validated during each deployment.

## Automating Setup

We leveraged the Power Platform Terraform provider to automate the setup process. This included creating environments, importing the Creator Kit, establishing connections, and installing the CoE Kit release files. By automating these steps, we ensured a consistent and repeatable setup process, which is crucial for automated verification. This approach not only saved time but also reduced the potential for human error, making our testing process more reliable and gives us the ability to deploy and test globally in multiple regions.

## Handling Conditional Dialogs

The custom page of the application introduced testing complexities such as the consent dialog that appears the first time the application runs. To handle this, we created a Power Fx function that conditionally checked for the consent dialog and approved it if it appeared. This approach simplified the process and ensured that our tests could run smoothly without manual intervention.

We does this look like? In one of our test steps we take advantage of the Power Fx extensions for test engine to add a command similar to the following.

```powerfx
TestEngine.ConsentDialog(Table({Text: "Center of Excellence Setup Wizard"}));
```

This function waits to see if the Consent Dialog Appears, if it does it accepts the connections. If the text "Center of Excellence Setup Wizard" appears then it continues with the remaining test steps.

## Using the PowerFX to extend testing

Power Fx and the extensibility model made it easy to hide complex operations like the conditional consent dialog behind simple Power Fx functions. This abstraction allowed us to focus on writing tests without worrying about the underlying complexities, making our testing process more efficient and maintainable.

The [ConsentDialogFunction](https://github.com/microsoft/PowerApps-TestEngine/blob/integration/src/testengine.module.mda/ConsentDialogFunction.cs) provides an example of the C# extenion to Test Engine that allows the complexity of the conditional consent dialog to be handled. This is a good example of combining the extensiblity model of code first C# extensions with low code PowerFX to simplify the test case.

## Custom Pages Dealing with Global Variables

Handling global variables was crucial for managing the steps of the install wizard. By effectively controlling the state of the application, we were able to test different parts of the process more easily. This approach ensured that our tests were robust and could handle various scenarios, ultimately improving the reliability of our automated testing framework.

## Scaling Guidance

In addition to focusing on the technical code elements of core functionality and tests, we are contributing to the wider low-code [testing guidance](https://github.com/microsoft/PowerApps-TestEngine/blob/grant-archibald-ms/docs/docs/README.md) based on our experiences so far. 

By sharing our learnings, we aim to help the broader community implement effective automated testing strategies, ensuring that others can benefit from our insights and improve their own testing processes.
