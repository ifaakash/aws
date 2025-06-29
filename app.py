import boto3
import os

# SNS client
sns = boto3.client('sns')

# Basic cost estimation logic
def estimate_s3_cost(storage_gb=5):
    # S3 STANDARD in us-east-2 = $0.023 per GB
    cost_per_gb = 0.023
    estimated_cost = storage_gb * cost_per_gb
    return round(estimated_cost, 2)

def lambda_handler(event, context):
    # Debug: print the full event for reference
    print("EventBridge Event:", event)

    # Extract bucket name from the event
    bucket_name = event['detail']['requestParameters']['bucketName']

    # Estimate cost
    estimated_cost = estimate_s3_cost()

    # Compose message
    message = (
        f" New S3 Bucket Created: {bucket_name}\n\n"
        f" Region: us-east-2\n"
        f" Storage Class: STANDARD\n"
        f" Estimated Monthly Cost (for 5GB): ${estimated_cost}\n\n"
        "You may update the estimate based on actual usage later."
    )

    # Send message via SNS
    sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],
        Subject="S3 Bucket Created - Estimated Cost Alert",
        Message=message
    )

    print("Email alert sent successfully.")
