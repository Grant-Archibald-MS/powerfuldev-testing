# CoE of Excellence Infrastructure As Code

The combination of Terraform and the CoE Starter Kit provides a powerful and flexible solution for managing and governing your Power Platform environments. By leveraging the power of infrastructure as code and the comprehensive tools provided by the CoE Starter Kit, you can ensure that your environments are always in a consistent and reliable state, enabling you to focus on delivering value to your users.

![Diagram that shows terraform and steps that will be automated as part of deployment](./media/coe-kit-infrastructure-as-code.png)

## Terraform

In the ever-evolving landscape of technology, the need for efficient and repeatable processes has never been more critical. Enter [Terraform](https://www.terraform.io/), a powerful tool that has revolutionized the way we manage infrastructure. For those new to Terraform, it is an open-source infrastructure as code (IaC) software tool that allows you to define and provision data center infrastructure using a high-level configuration language. Terraform makes it easy to define and verify that created resources are consistent and repeatable, ensuring that your infrastructure is always in the desired state.

Using infrastructure as code is you to manage and provision infrastructure through code, which can be source-controlled and managed alongside your application code. This means that your infrastructure can be versioned, reviewed, and tested just like any other piece of software. With Terraform, you can define your infrastructure in a declarative configuration file, and Terraform will handle the rest, ensuring that your infrastructure is always in sync with your configuration.

One of the standout features of Terraform is its extensibility. There is a specific [Power Platform Terraform provider](https://registry.terraform.io/providers/microsoft/power-platform/latest/docs) that allows you to manage Power Platform resources using Terraform. This provider can be combined with other Terraform providers, enabling you to mix and match Power Platform resources with any other resources you want to deploy as part of your end-to-end process. This flexibility makes Terraform an invaluable tool for managing complex, multi-cloud environments.

## CoE Starter Kit Sample

Collaborating with the Power Platform quick start team the Power CAT Engineeing team has collaborated to build a [CoE Starter Kit Quick start Terraform sample](https://github.com/microsoft/power-platform-terraform-quickstarts/tree/mawasile/coe-kit-iac-quickstart/quickstarts/202-coe-starter-kit). The sample demonstrates how to create an environment within a region, create connections required by the CoE Starter Kit as the user persona, import Power Platform dependencies of the Creator Kit, import a version of the CoE Starter Kit, and validate that the setup and upgrade process works as expected by running defined test cases. This ensures that your Power Platform environments are always in a consistent and reliable state.

## Automation Test Roadmap

Setting up and integrating a Terraform deployment model for the CoE Starter Kit is a crucial step in automating and simplifying the setup of environments with different settings. This approach allows you to move towards a matrix deployment model with multiple versions, enabling you to upgrade and validate functionality across multiple geographical regions. By automating these processes, you can ensure that your environments are always up-to-date and functioning correctly, reducing the risk of errors and improving overall efficiency.
