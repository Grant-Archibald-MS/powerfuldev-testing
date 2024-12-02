# Simulating Dataverse

## Introduction

The `Experimental.SimulateDataverse` function allows you to simulate responses from the Dataverse without actually querying the live data. This is particularly useful for testing and development purposes, as it enables you to create predictable and controlled responses for various scenarios.

## What is Mocking?

Mocking is a technique used in software testing to simulate the behavior of real objects. By using mocks, you can create controlled environments where you can test specific parts of your application in isolation. This helps ensure that your tests are reliable and repeatable, as they are not dependent on external factors.

### Benefits of Mocking

- **Test Isolation**: Mocking allows you to isolate the component you are testing from the rest of the system. This means you can focus on testing the functionality of that component without worrying about the behavior of other parts of the system.
- **Control Over Test Scenarios**: By using mocks, you can create specific scenarios, including both expected and edge cases. This helps you verify that your application behaves correctly under various conditions.
- **Consistency**: Mocking ensures that your tests produce consistent results, as the mocked responses are predefined and do not change.

## Using Experimental.SimulateDataverse

The `Experimental.SimulateDataverse` function allows you to define simulated responses for Dataverse actions such as query, create, update, and delete. Here is the syntax:

    ```powerfx
    Experimental.SimulateDataverse({ Action: "Query", Entity: "TableName", When: { Field: "value" }, Then: Table({Name: "Test"}) })
    ```

## Parameters


| Name	| Description |
|-------|-------------|
|Action |The Dataverse action to simulate (e.g., Query, Create, Update, Delete).
|Entity	| The pluralized entity name from metadata.
|When	|The optional query string to apply.
|Filter	| A Power Fx expression that needs to be matched. This will automatically be mapped to the OData $filter command.
| Then	| The Power Fx table to return in the OData value response that will be returned to the Power App.

## Recording Sample Values

To obtain values for the Experimental.SimulateDataverse function, you can:

1. Use the network trace of the Browser Developer Tools when using Experimental.Pause(). Filter the traffic by searching for /api/data/v.

2. Use [Recording your first test](./05-recording-your-first-test.md) to record an app that queries Dataverse.

## Example
1. Simulate a Query Response with Sample Data. When the Power App queries all accounts, respond with sample data:

    ```powerfx
    Experimental.SimulateDataverse({Action: "query", Entity: "accounts", Then: Table({accountid: "a1234567-1111-2222-3333-44445555666", name: "Test"}) })
    ```

2. Simulate a Query with Specific Conditions. When a request is made with an account query name of "Other", return no results:

    ```powerfx
    Experimental.SimulateDataverse({Action: "query", Entity: "accounts", When: {Name: "Other"}, Then: Table()})
    ```

## Why This Function is Useful

The Experimental.SimulateDataverse function is useful because it allows developers and makers to:

- Test and Debug: Simulate different scenarios and responses without affecting live data, making it easier to test and debug applications.
- Predictable Results: Create controlled and predictable responses, which is essential for automated testing and ensuring consistent behavior.
- Development Efficiency: Speed up the development process by allowing developers to work with simulated data instead of waiting for actual data to be available.

By using this function, you can ensure that your Power Apps behave as expected in various scenarios, leading to more robust and reliable applications.