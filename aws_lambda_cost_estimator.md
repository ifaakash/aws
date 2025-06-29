## 🚀 How AWS Lambda Was Used

AWS Lambda was the core of this project — it acted as the serverless processing engine that responded automatically to resource creation events.

### Key Responsibilities of the Lambda Function:

- **Triggered by EventBridge:**  
  The Lambda function was invoked automatically whenever a new AWS resource (e.g., an S3 bucket) was created. This was made possible by setting up an EventBridge rule that listened to CloudTrail logs for specific API actions like `CreateBucket`.

- **Tag Filtering Logic:**  
  Once triggered, the Lambda function parsed the incoming event, identified the resource (e.g., bucket name), and used `boto3` to fetch the associated resource tags. If the tag `project: poc` was present, the function proceeded to cost estimation.

- **Cost Estimation Logic:**  
  The function either queried the AWS Pricing API or used predefined cost metrics (e.g., S3 storage costs) to estimate the monthly expense of the newly created resource.

- **Output & Logging:**  
  The estimated cost was logged to CloudWatch for visibility. In future iterations, this can be extended to send email or Slack notifications.

By using Lambda, the entire process remained serverless, event-driven, and cost-efficient — aligning perfectly with AWS best practices.
