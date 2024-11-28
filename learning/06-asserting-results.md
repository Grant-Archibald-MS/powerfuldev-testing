# Asserting Results

## Introduction to Asserts

In automated testing, an **assert** is a statement that checks if a condition is true. If the condition evaluates to true, the test passes; if it evaluates to false, the test fails. Asserts are crucial for verifying that your application behaves as expected.

## The Assert Power Fx Function

The `Assert` function in Power Fx takes two arguments:
1. A boolean expression that evaluates to true or false.
2. A message that describes the assertion.

If the boolean expression evaluates to true, the test step passes. If it evaluates to false, the test step fails, and the provided message helps identify the issue.

### Syntax

```powerfx
Assert(boolean_expression, "message")
```

## Example

Let's consider an example where we want to assert that the value of Label1.Text is equal to "Heading":

```powerfx
Assert(Label1.Text = "Heading", "Label1 should display 'Heading'")
```

In this example, if Label1.Text is "Heading", the test step will pass. If it is not, the test step will fail, and the message "Label1 should display 'Heading'" will be shown.

## Using Assert in a Test Plan

In the [testPlan.fx.yaml](https://github.com/microsoft/PowerApps-TestEngine/blob/main/samples/buttonclicker/testPlan.fx.yaml) file, you can include assert statements to validate your application's behavior. Let's look at an example from the Button Clicker sample.

### Example from Button Clicker Sample

The testPlan.fx.yaml file in the Button Clicker sample includes the following assert statement:

```powerfx
Assert(Label1.Text = "1", "Counter should be incremented to 1")
```

This assert checks that Label1.Text is equal to "1". If the counter is correctly incremented to 1, the test step passes. If not, the test step fails, and the message "Counter should be incremented to 1" is displayed.

### Steps to Use Assert in Your Test Plan

1. Open the testPlan.fx.yaml File:

2. Navigate to the \samples\buttonclicker\ directory.

3. Open the testPlan.fx.yaml file in a text editor.

4. Add or chage an Assert Statement:

```powerfx
Assert(Label1.Text = "Heading", "Label1 should display 'Heading'")
```

5. Save the changes to the testPlan.fx.yaml file.

6. Run the test script by executing:

```pwsh
pwsh -File RunTests.ps1
```

7. Review the Results:

After the test completes, review the results in the TestOutput folder.

Check the .trx file and individual test case folders to see if the assert statements passed or failed.

By using assert statements in your test plans, you can ensure that your application behaves as expected and quickly identify any issues that need to be addressed.