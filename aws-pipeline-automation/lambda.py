import boto3
import paramiko
import os

# Initialize the EC2 client
ec2_client = boto3.client('ec2', region_name='sa-east-1')

# EC2 instance details
EC2_INSTANCE_ID = 'YOUR INSTANCE ID'
EC2_USER = 'YOUR EC2 USER'
REGION = 'sa-east-1'

# Path to your private key file
PRIVATE_KEY_PATH = 'gostosamente.pem'

def lambda_handler(event, context):
    try:
        print("Starting execution")
        repository_name = 'gostosamente'
        image_tag = 'latest'

        # Initialize the ECR client
        ecr_client = boto3.client('ecr', region_name=REGION)

        # Get the public ECR URI
        response = ecr_client.describe_repositories(repositoryNames=[repository_name])
        repository_uri = response['repositories'][0]['repositoryUri']
        image_uri = f"{repository_uri}:{image_tag}"

        print(f"Repository URI: {repository_uri}")
        print(f"Image URI: {image_uri}")

        # Describe the instance to get its availability zone and public IP
        ec2_instance = ec2_client.describe_instances(InstanceIds=[EC2_INSTANCE_ID])
        ec2_ip = ec2_instance['Reservations'][0]['Instances'][0]['PublicIpAddress']
        ec2_az = ec2_instance['Reservations'][0]['Instances'][0]['Placement']['AvailabilityZone']

        print(f"EC2 IP: {ec2_ip}")
        print(f"EC2 AZ: {ec2_az}")

        # Load the existing private key
        try:
            key = paramiko.RSAKey.from_private_key_file(PRIVATE_KEY_PATH)
            print("Private key loaded successfully")
        except Exception as e:
            print(f"Failed to load private key: {str(e)}")
            return {
                'statusCode': 500,
                'body': f"Failed to load private key: {str(e)}"
            }

        # Command to login to ECR
        command_one = f"sudo aws ecr get-login-password --region sa-east-1 | sudo docker login --username AWS --password-stdin yourid.dkr.ecr.sa-east-1.amazonaws.com | sudo docker pull {image_uri} && sudo docker stop gostosamente || true && sudo docker rm gostosamente || true && sudo docker run -d --name gostosamente -p 80:8080 {image_uri}"

        # Use Paramiko to establish an SSH connection
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(ec2_ip, username=EC2_USER, pkey=key)
            print("SSH connection established")
        except paramiko.AuthenticationException as auth_error:
            print(f"Authentication failed: {str(auth_error)}")
            return {
                'statusCode': 500,
                'body': f"Authentication failed: {str(auth_error)}"
            }
        except Exception as e:
            print(f"Failed to establish SSH connection: {str(e)}")
            return {
                'statusCode': 500,
                'body': f"Failed to establish SSH connection: {str(e)}"
            }

        # Execute the command to login to ECR
        try:
            stdin, stdout, stderr = ssh.exec_command(command_one)
            stdout_output = stdout.read().decode()
            stderr_output = stderr.read().decode()
            print(f"STDOUT: {stdout_output}")
            print(f"STDERR: {stderr_output}")
        except Exception as e:
            print(f"Error executing command: {str(e)}")
            return {
                'statusCode': 500,
                'body': f"Error executing command: {str(e)}"
            }

        ssh.close()

        return {
            'statusCode': 200,
            'body': f"Successfully deployed gostosamente!"
        }

    except Exception as e:
        print(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': f"Error: {str(e)}"
        }

lambda_handler({}, {})
