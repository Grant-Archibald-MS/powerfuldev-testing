---
title: "Interactive Learning Modules with Power Fx"
categories:
  - Updates
tags:
  - PowerPlatform
  - Learning
  - PowerFx
---

Welcome to our latest update on PowerfulDev Testing! We're excited to introduce a set of interactive concept "Try It" block into to our [technical learning path modules](/powerfuldev-testing/learning). These learning concept blocks are designed to help you master Power Fx and level up the skills to enable you to build tests that can validate the behavior of your solutions.

These modules will guide you through key concepts on getting started creating low code tests and provide practical examples that you can apply directly to your projects. At each stage if you want to explore the concepts you can use the link to the learning playground to explore the concepts and build on your understanding.

The best part about the new learning blocks is you can interactively try the concepts directly in your browser without the need to sign in and setup the low code solution. Our goal is to you working the key concepts as soon as possible to that you can apply teh skills you learn to adding automated tests to the solutions you build.

## Example: Creating a Dynamic Greeting

Let have a quick look at the ability to Power Fx commands in the browser to rapidly try an idea. The editor block below allows you to create a dynamic greeting message that changes based on the time of day.

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