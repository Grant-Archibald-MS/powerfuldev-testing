# Using Power Fx Namespaces in Testing

**NOTE** Namespaces are a preview feature only avilable in early release integration branches of the Power Apps test engine.

## Introduction to Power Fx Namespaces
Power Fx namespaces are a powerful feature that allows developers to organize and separate different sets of functions within the Power Fx language. By using namespaces, you can distinguish between the default functions provided by Power Fx, such as `CountRows()`, and extensions added for specific purposes, like the Test Engine with functions such as `TestEngine.Pause()`. This separation helps in maintaining clarity and avoiding conflicts between different sets of features.

## Common Features vs. Specific Actions
Namespaces make it clear what are common features of the Power Fx language and what are specific actions unique to certain extensions. For example, functions like `CountRows()` are part of the core Power Fx language and are available universally. On the other hand, functions like `TestEngine.Pause()` are specific to the Test Engine and are used exclusively within the context of testing Power Apps. This distinction helps developers understand the scope and applicability of each function, ensuring that they use the right tools for the right tasks.

## Separating Wider Usage Actions from Experimental Features
Namespaces also allow developers to separate actions that have wider usage from those that are experimental and subject to change. For instance, the `Experimental` namespace can be used for early concepts and features that are still being tested and refined. By placing these features in a separate namespace, developers can experiment with new ideas without affecting the stability of their main applications. This approach encourages innovation while maintaining a clear boundary between stable and experimental features.

## Progression from Experimental to TestEngine Namespace
As features mature and become more stable, they can progress from the `Experimental` namespace to more specialized namespaces like `TestEngine`. This progression indicates that the features have been tested and refined, and are now ready for broader use in specific contexts. For example, a function that starts in the `Experimental` namespace for testing purposes might eventually move to the `TestEngine` namespace once it has proven its reliability and usefulness in testing scenarios. This structured progression helps in managing the lifecycle of features and ensures that only well-tested functionalities are used in production environments.

## Managing Namespaces in Test Settings

Namespaces in Power Fx can be managed through the test settings in the YAML configuration. This ability allows you to specify the allow and deny list values to control which namespaces are enabled. By default, the `TestEngine` namespace is allowed. When using a build-from-source strategy, the `Experimental` namespace will also be added when compiling with Debug. 

These settings can be overridden by using the deny configuration. Here is an example of how to configure the test settings in YAML:

```yaml
testSettings:
  headless: false
  locale: "en-US"
  recordVideo: true
  extensionModules:
    enable: true
    allowNamespaces:
      - Experimental
```

## Conclusion
In summary, Power Fx namespaces provide a structured way to organize and separate different sets of functions within the language. They help in distinguishing between common features and specific actions, separating stable functionalities from experimental ones, and managing the progression of features from experimental to specialized contexts. By using namespaces effectively, developers can maintain clarity, avoid conflicts, and ensure the stability and reliability of their Power Apps.