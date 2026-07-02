"""
================================================
Healthcare Cloud Pipeline — S3 Ingestion
Author:      Rex M. Burdette | rex@rexsixsigma.com
Platform:    AWS S3 + Python (boto3)
Layer:       Source -> Cloud Storage
Description: Pulls real, publicly published CDC NSSP
             emergency department respiratory illness
             data and uploads it to an S3 bucket as the
             landing zone for downstream Alteryx
             transformation and Snowflake loading.
Bucket:      rmb3000-cdc-respiratory-2026
Output:      A timestamped CSV file in S3, under the
             raw/ prefix, ready for Alteryx to pick up.
================================================

SETUP REQUIRED BEFORE RUNNING:
1. Install boto3:  pip install boto3 pandas requests --break-system-packages
2. Configure AWS credentials. The easiest way:
   - Install the AWS CLI if you don't have it
   - Run: aws configure
   - Enter your Access Key ID, Secret Access Key, region (e.g. us-east-1)
   These come from AWS Console > IAM > Users > [your user] > Security credentials > Create access key
"""

import boto3
import pandas as pd
import requests
from datetime import datetime, timezone
from io import StringIO

# --- Configuration ---
BUCKET_NAME = "rmb3000-cdc-respiratory-2026"
CDC_CSV_URL = "https://data.cdc.gov/api/views/7xva-uux8/rows.csv?accessType=DOWNLOAD"
S3_PREFIX = "raw"  # folder-like prefix inside the bucket

def pull_cdc_data():
    """Pull the real CDC NSSP respiratory surveillance CSV."""
    print(f"Pulling CDC data from: {CDC_CSV_URL}")
    df = pd.read_csv(CDC_CSV_URL)
    print(f"Rows pulled: {len(df):,}")
    print(f"Columns: {list(df.columns)}")
    print(f"Most recent week_end in this pull: {df['week_end'].max()}")
    return df

def upload_to_s3(df, bucket_name, prefix):
    """Upload a DataFrame to S3 as a timestamped CSV."""
    s3_client = boto3.client("s3")

    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    key = f"{prefix}/cdc_respiratory_{timestamp}.csv"

    csv_buffer = StringIO()
    df.to_csv(csv_buffer, index=False)

    s3_client.put_object(
        Bucket=bucket_name,
        Key=key,
        Body=csv_buffer.getvalue()
    )

    print(f"\nUploaded to s3://{bucket_name}/{key}")
    print(f"File size: {len(csv_buffer.getvalue()):,} bytes")
    return key

if __name__ == "__main__":
    df = pull_cdc_data()
    s3_key = upload_to_s3(df, BUCKET_NAME, S3_PREFIX)
    print(f"\nDone. Alteryx can now pull from: s3://{BUCKET_NAME}/{s3_key}")
