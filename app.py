import json

# Trigger the lambda when an event is triggered
def lambda_handler(event, context):
    print("Event received:")
    print(json.dumps(event, indent=2))

    return {
        'statusCode': 200,
        'body': json.dumps('Event processed successfully!')
    }
