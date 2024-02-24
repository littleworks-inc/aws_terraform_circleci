Certainly! Below is the updated README file with instructions on how to configure the CircleCI pipeline from the CircleCI interface:

---

# CircleCI Pipeline Configuration for Terraform Deployment

This repository contains the CircleCI pipeline configuration for deploying infrastructure using Terraform, with support for multiple environments (dev, test, prod).

## Overview

The CircleCI pipeline is designed to automate the deployment of infrastructure using Terraform while ensuring consistency and reliability across different environments. The pipeline consists of several jobs, including linting, Terraform plan, Terraform apply, and manual approval steps.

## Jobs

### `tfsec`

- **Executor:** `tfsec`
- **Description:** This job runs tfsec, a static analysis tool for Terraform code, to ensure adherence to security best practices.

### `terraform-plan`

- **Executor:** `terraform`
- **Description:** This job initializes Terraform, validates the configuration, and generates an execution plan. The environment type (`ENV_TYPE`) is determined based on the branch name (`$CIRCLE_BRANCH`), and the appropriate backend configuration and variable files are used accordingly.

### `terraform-apply`

- **Executor:** `terraform`
- **Description:** This job initializes Terraform and applies the changes to the infrastructure. Similar to the `terraform-plan` job, the environment type (`ENV_TYPE`) is determined based on the branch name, and the appropriate backend configuration and variable files are used.

### `hold`

- **Description:** This job represents a manual approval step. It requires approval before proceeding to the `terraform-apply` job.

## Workflow

### `build_approve_deploy`

This workflow orchestrates the deployment process and consists of the following steps:

1. **`tfsec`**: Run tfsec to analyze the Terraform code for security vulnerabilities.
2. **`terraform-plan`**: Generate an execution plan for Terraform based on the branch name. The plan is displayed for review.
3. **`hold`**: Manual approval step. Requires approval before proceeding to apply changes.
4. **`terraform-apply`**: Apply the Terraform changes to the infrastructure after approval.

## Branch-based Environment Configuration

The pipeline dynamically selects the appropriate environment configuration based on the Git branch name (`$CIRCLE_BRANCH`). The environment type (`ENV_TYPE`) is set accordingly, allowing seamless deployment to different environments.

### Environment Mapping

- **dev**: Development environment
- **test**: Testing environment
- **master**: Production environment

## CircleCI Configuration

### Setting Environment Variables

1. **Open Organization Settings**: Navigate to the CircleCI organization settings from the menu.
2. **Create Context**: Inside the organization settings, create a context for managing environment variables.
3. **Add Variables**: Within the context, add the following variables:
   - `AWS_ACCESS_KEY_ID`: AWS access key ID for accessing AWS services.
   - `AWS_SECRET_ACCESS_KEY`: AWS secret access key corresponding to the access key ID.
   - Other environment-specific variables as required for your deployment.

## Example Configuration

Below is an example of how the pipeline configuration adapts to different branches:

- **Dev Branch (`dev`)**: The pipeline deploys changes to the development environment using `dev_backend.hcl` and `dev.tfvars`.
- **Test Branch (`test`)**: The pipeline deploys changes to the testing environment using `test_backend.hcl` and `test.tfvars`.
- **Master Branch (`master`)**: The pipeline deploys changes to the production environment using `prod_backend.hcl` and `prod.tfvars`.
