# CI/CD Automation Workflow

This project demonstrates a CI/CD automation workflow that integrates GitHub Actions, Amazon Elastic Container Registry (ECR), and AWS Lambda to automate the deployment of a Docker image to an EC2 instance. The workflow consists of three main steps:

1. **Create a Pull Request (PR) from `develop` to `main` branch.**
2. **Build and Push Docker Image to Amazon ECR.**
3. **Deploy the New Docker Image to an EC2 Instance via AWS Lambda.**

## Workflow Details

### 1. Creating a Pull Request from `develop` to `main`

Whenever there is a push to the `develop` branch, a GitHub Actions workflow is triggered to automatically create a pull request (PR) from the `develop` branch to the `main` branch. The PR is created using the GitHub Actions' `create-pull-request` action.

- **Action:** [`peter-evans/create-pull-request`](https://github.com/peter-evans/create-pull-request)
- **Trigger:** On push to `develop` branch.
- **Outcome:** An automated pull request to merge changes from `develop` to `main`.

### 2. Building and Pushing Docker Image to Amazon ECR

Once the pull request is reviewed and merged into the `main` branch, another GitHub Actions workflow is triggered to build a Docker image and push it to the Amazon Elastic Container Registry (ECR). This step ensures that the latest changes are included in the Docker image.

- **Steps:**

  - **Build Docker Image:** Uses the `docker` CLI to build the Docker image.
  - **Push Docker Image to ECR:** The Docker image is tagged and pushed to the Amazon ECR repository.

- **Tools:**
  - **Docker CLI:** Used for building and managing Docker images.
  - **AWS CLI:** Used to authenticate and push Docker images to Amazon ECR.

### 3. Deploying the New Docker Image using AWS Lambda

After the Docker image is pushed to ECR, an AWS Lambda function is triggered to deploy the new Docker image to an EC2 instance. The Lambda function establishes an SSH connection to the EC2 instance, logs into ECR, pulls the new Docker image, stops any existing container, and runs the updated container.

- **Lambda Function Details:**
  - **Establishes SSH Connection:** Connects to the EC2 instance using SSH with the provided private key.
  - **Logs into ECR:** Uses the AWS CLI to log in to ECR from the EC2 instance.
  - **Pulls and Runs Docker Image:** Pulls the latest Docker image from ECR, stops any running containers, and runs the new Docker image.

This works for our purpose at the moment, we will migrate to EKS on the future.
