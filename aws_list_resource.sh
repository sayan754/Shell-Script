
#!/bin/bash

####################################################################
# This script will list all the active resources in the AWS account
# Author : Sayan/DevOps
# Version : v0.0.1


# Following are the supported AWS services by the script:
# 1. EC2
# 2. IAM
# 3. S3
# 4. VPC
# 5. SNS
# 6. EBS
# 7. Route53
# 8. CLamba


# Usage : ./aws_list_resource.sh <region> <service_name>
# Example : ./aws_list_resource.sh us-east-1 S3
##################################################################


# Check if the required number of arguments are passed:
if [ $# -ne 2 ]; then      # no of command line arguments are equal to 2 or not we are verifying
  echo "Usage: $0 <region> <service_name>"
  exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2


# Check if AWS CLI is installed:
if ! command -v aws &> /dev/null; then
  echo "AWS CLI is not installed. Please install it and try again"
  exit 1
fi

# Check if AWS CLI is configured:
if [ ! -d ~/.aws ]; then
  echo "AWS CLI is not configured. Please configure and try again"
  exit 1
fi

# Execute the AWS CLI command based on service  name:
case $2 in
   ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac



