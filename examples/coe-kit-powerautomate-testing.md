# CoE Starter Kit Power Automate Testing

## Important Note

The Test Engine Power Automate features are currently in the planning and early collaboration and code contributions to Test Engine for the approach outlined below. 

This article aims to serve as a starting point for discussion on how this feature could meet the needs of users who are building and deploying Power Automate Cloud flows. It is important to note that this feature is still in the early stages of planning and experimentation. We invite the community to be part of the discussion and to stay aware as the scope and features develop.

## Importance of Testing Power Automate in the CoE Starter Kit

Testing Power Automate is crucial for the CoE Starter Kit, which has over 100 cloud flows defined to collect inventory and usage data for the tenant. Ensuring these flows work correctly is essential for maintaining accurate data collection and reporting. Proper testing helps identify and fix issues early, improving the reliability and performance of the flows. This, in turn, supports better decision-making and governance within the organization.

## Exploring the Testing Layers

Before we begin, it is important to understand that there are multiple layers of testing that could be applied to Power Automate Cloud flows in the CoE Kit. The first layer involves testing when the flow is called from a Power App. The second layer focuses on testing the logic flow of a cloud flow using simulated values for connections. The third layer involves conducting integrated tests for the cloud flow with different inputs and outputs.

{% include figure popup=true image_path="/examples/media/coe-kit-powerautomate-layers.png" alt="Diagram that shows the different layers from Power Apps to Power Automate, Power Automate to simulated connectors and third integration tests of the cloud flow" caption="Power Automate Layers" %}

### Layer 1: Testing from Power App

Testing from a Power App involves simulating that when cloud flow triggered and that it interacts properly with the Power App. This layer ensures that the the Power App reacts to normal data flows and edge cases from the flow work as expected.

Pros:

- Ensures isolated functionality where you can control the response of the simulated workflow.
- Validates user interactions with the Power App.

Cons:

- Does not test the end to end functionality.
- Will need to be updated to reflect changes in the response from the cloud flow for new scenarios.

### Layer 2: Testing Logic Flow with Simulated Values

This layer focuses on testing the internal logic of the cloud flow using simulated values for connections. By simulating connector responses and Dataverse calls, we can validate the flow's logic without relying on external systems.

Pros:

- Isolates the flow's logic for focused testing.
- Allows testing of various scenarios and edge cases.

Cons:

- May not fully replicate real-world conditions.
- Requires accurate simulation of external systems.

Considerations:

- Ensure that simulated values accurately represent real-world data.
- Validate that the flow's logic handles all possible scenarios.

### Layer 3: Integrated Testing with Different Inputs and Outputs

Integrated testing involves running the cloud flow with different inputs and outputs to validate its overall functionality. This layer ensures that the flow works correctly in various scenarios and handles different data inputs and outputs.

Pros:

- Provides comprehensive testing of the flow.
- Validates the flow's behavior in real-world conditions.

Cons:

- Can be time-consuming.
- Requires a variety of test data.

Considerations:

- Ensure that test data covers all possible scenarios.
- Validate that the flow handles different inputs and outputs correctly.

### The role of Simulation

By being able to interact with variable values and simulate connectors and Dataverse calls, the process of testing the control logic and error handling of a cloud flow becomes easier.

## Layer 1 Example - Integration Testing from Power App

Lets look at the first layer of the scenario above integration testing from Power App where we simulate the result of a call to a workflow. This starts with testing the Setup and Upgrade Wizard and using the `Experimental.SimulateWorkflow()` function to allow integration testing of a deployed application.

## Example of Setup Wizard > Get User Details

### Testing from Power App

One of the steps of the tests for the Power App for could be the following. 

```powerfx
Experimental.SimulateWorkflow({
    Name: "SetupWizard>GetUserDetails",
    Then: {haspowerapps:"Yes",haspowerautomate:"No"}
});
```

This action would allow requests to the workflow to be replaced with a value provided as part of the test case definition. 

### Layer 2 Example - Testing the Power Automate Cloud Flow Actions

Lets now look at the second layer of testing where we simulate the trigger values, connectors and Dataverse state. While the the first layer is useful for testing the Power App it does not address how we can test the actions within this workflow. Let have a look at the definition of a sample cloud flow from the CoE Kit and how it could fit into the Test Engine.

{% include figure popup=true image_path="/examples/media/coe-kit-setup-wizard-getuserdetails-overview.png" alt="Overview diagram that shows Power Fx, Power Automate Provider and screenshot of steps of the SetupWizard>GetUserDetails cloud flow" caption="Setup Wizard Get User Details Overview" %}

The `SetupWizard>GetUserDetails` flow determines if the current user has licenses for Power Apps and Power Automate. Lats have a look at the the key steps of the Power Automate Flow. 

{% include figure popup=true image_path="/examples/media/coe-kit-setup-wizard-getuserdetails-start.png" alt="Screenshot of first steps of the SetupWizard>GetUserDetails cloud flow" caption="Starting steps" %}


The flow is triggered from Power Automate and creates a variable to determine the graph endpoint to use. This process queries an environment variable to get an environment value if defined. If not, it defaults to the commercial cloud endpoint of `https://graph.microsoft.com`. 

{% include figure popup=true image_path="/examples/media/coe-kit-setup-wizard-getuserdetails-environment-variable.png" alt="Screenshot of query environment variable of the SetupWizard>GetUserDetails cloud flow" caption="Environment Variables" %}

Having found the correct graph endpoint, it then calls the graph API to query the license details assigned to the user to determine if the correct Power Apps and Power Automate License has been assigned.

{% include figure popup=true image_path="/examples/media/coe-kit-setup-wizard-getuserdetails-graph-query.png" alt="Screenshot of query Microsoft Grpah in the SetupWizard>GetUserDetails cloud flow" caption="Graph Query" %}

The need to test scenarios like these leads us to consider extending Test Engine to introduce a new Provider for Power Automate that allows unit testing of Power Automate Cloud flows. This would validate the logic by enabling the validation of variable values and the simulation of connectors and Dataverse calls.

#### Extended Power Fx Test Steps for Power Automate Testing

Let's have a look at how this cloud flow could be tested using Test Engine using a test that simulates triggers, connections and dataverse calls

```powerfx
// Start the workflow with empty parameters
Experimental.TriggerWorkflow({});

// Verify empty value
Experimental.BeforeAction([Get User Details Scope], Assert(GraphUrl, ""));

// Simulate calls to dataverse and connectors with sample data
Experimental.SimulateDataverse({
    Action: "Query",
    Entity: "Environment Variable Definitions",
    Then: Table({environmentvariabledefinitionid: "a1234567-1111-2222-3333-44445555666" })
});
Experimental.SimulateDataverse({
    Action: "Query",
    Entity: "Environment Variable Values",
    Then: Table({Value: "https://graph.microsoft.com" })
});
Experimental.SimulateConnector({
    Name: "webcontents",
    Then: Table({id: "11111111-0000-0000-0000-22222222222", skuId: "", skuPartNumber: "POWERAPPS_PER_USER" })
});

// Verify selected Graph endpoint and Results of the flow
Experimental.BeforeAction([Invoke an HTTP request], Assert(GraphUrl, "https://graph.microsoft.com"));
Experimental.AfterAction([Respond to a PowerApp or flow],Assert([Respond to a PowerApp or flow].haspowerapps = "Yes"));
Experimental.AfterAction([Respond to a PowerApp or flow],Assert([Respond to a PowerApp or flow].haspowerautomate ="No"));
```

 Power Fx Function                | Parameters                                                                 | Usage                                                                                                      |
|----------------------------------|----------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Experimental.TriggerWorkflow()   | {}                                                                         | Triggers the workflow to start the testing process.In this case with no parameters,                                                       |
| Experimental.BeforeAction()      | [Action], Assert(Parameter, Value)                                         | Executes assertions before a specified action to ensure the initial conditions are met.                    |
| Experimental.SimulateDataverse() | { Action: "Query", Entity: "EntityName", Then: Table({Column: "Value"}) }  | Simulates a Dataverse query to return predefined values, allowing the testing of logic that depends on Dataverse data. |
| Experimental.SimulateConnector() | { Name: "ConnectorName", Then: Table({Column: "Value"}) }                  | Simulates a connector call to return predefined values, enabling the testing of logic that depends on external connectors. |
| Experimental.AfterAction()       | [Action], Assert(Parameter, Value)                                         | Executes assertions after a specified action to ensure the expected outcomes are achieved.                 |

By being able to interact with variable values and simulate connectors and Dataverse calls, the process of testing the control logic and error handling of a cloud flow becomes easier.

## Summary

This proposed feature demonstrates the ability to use Power Fx as a common language to not only test Power Apps but other Power Platform components. This builds on the extensibility of Power Fx to test from a Power App using `Experimental.SimulateWorkflow()` and add new actions like `Experimental.TriggerWorkflow()`, `Experimental.BeforeAction()`, and `Experimental.AfterAction()` that apply when testing a Power Automate Cloud flow using simulated state isolated from the end to end system.
