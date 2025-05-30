import boto3
import json
import os
from datetime import datetime

s3 = boto3.client("s3")
BUCKET_NAME = os.environ.get("BUCKET_NAME", "default-bucket")

def generate_portfolio():
    return {
        "portfolio_id": "P12345",
        "assets": [
            {"type": "equity", "symbol": "AAPL", "quantity": 50, "value": 7500},
            {"type": "bond", "symbol": "US10Y", "quantity": 10, "value": 10000}
        ],
        "valuation_date": datetime.utcnow().isoformat(),
        "total_value": 17500
    }

def lambda_handler(event, context):
    data = generate_portfolio()
    filename = f"portfolio_snapshot_{datetime.utcnow().strftime('%Y%m%dT%H%M%S')}.json"
    s3.put_object(Bucket=BUCKET_NAME, Key=filename, Body=json.dumps(data))
    return {"status": "ok", "file": filename}
