---
title: "Interactive Learning Modules with Power Fx"
categories:
  - Updates
tags:
  - PowerPlatform
  - Learning
  - PowerFx
---

Welcome to our latest update on PowerfuleDev Testing! We're excited to introduce a set of interactive updates to our [technical learning path modules](/powerfuldev-testing/learning) designed to help you master Power Fx. These modules will guide you through key concepts on getting started creating low code tests and provide practical examples that you can apply directly to your projects.

## Example: Creating a Dynamic Greeting

In this example, we'll create a dynamic greeting message that changes based on the time of day.

Create a Label Control: Add a label control to your canvas app.
Set the Text Property: Use the following Power Fx formula to set the text property of the label:

{% powerfx %}
If(
    Hour(Now()) < 12, 
    "Good Morning!", 
    If(
        Hour(Now()) < 18, 
        "Good Afternoon!", 
        "Good Evening!"
    )
)
{% endpowerfx %}

This formula checks the current hour and displays an appropriate greeting message.

## Learning Playground

Want to explore more related learning tasks directly inside your browser? You can checkout the <a href="/powerfuldev-testing/learning/playground?title=boolean-expressions" class="btn btn--primary">Learning Playground</a> to explore related testing concepts.

## Expanding the Approach

Based on your feedback, we plan to expand these modules to cover more advanced concepts in Power Fx. This will include creating complex formulas, integrating with other Power Platform tools, and optimizing performance. Our goal is to make it easier for you to adjust and enhance your test cases.

Stay tuned for more updates and happy learning!