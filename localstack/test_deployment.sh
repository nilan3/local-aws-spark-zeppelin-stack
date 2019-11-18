#!/bin/bash

# S3
aws --endpoint-url=http://localhost:4572 s3 mb s3://dap-test-local-bucket
aws --endpoint-url=http://localhost:4572 s3 cp test-s3-file.txt s3://dap-test-local-bucket/

# Lambda
zip lambda_function.zip lambda_function.py
aws --endpoint-url=http://localhost:4574 lambda create-function \
    --region eu-west-2 \
    --function-name local-test-function \
    --runtime python3.7 \
    --handler lambda_function.handler \
    --memory-size 128 \
    --zip-file fileb://lambda_function.zip \
    --role arn:aws:iam::123456:role/notavailable
rm lambda_function.zip

# DynamoDB
aws --endpoint-url=http://localhost:4569 dynamodb create-table \
    --table-name LocalTestTable \
    --attribute-definitions \
        AttributeName=Name,AttributeType=S AttributeName=Desciption,AttributeType=S \
    --key-schema AttributeName=Name,KeyType=HASH AttributeName=Desciption,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
aws --endpoint-url=http://localhost:4569 dynamodb put-item \
    --table-name LocalTestTable \
    --item '{
        "Name": {"S": "Nilan Balachandran"},
        "Description": {"S": "Data Analytics Platform"} ,
        "Role": {"S": "Engineer"} }' \
    --return-consumed-capacity TOTAL
