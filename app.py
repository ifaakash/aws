import json

def lambda_handler(event, context):
    print("Event received:")
    print(json.dumps(event, indent=2))

    return {
        'statusCode': 200,
        'body': json.dumps('Event processed successfully!')
    }
