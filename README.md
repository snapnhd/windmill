# Windmill on Render

This is a simple setup for running Windmill on Render.

## Setup

1. on your render dashboard, create a "Blueprint" (click + New on the top right of the dashboard)
2. select this github repo as the source
3. Setup MinIO as instance storage
- Connect to the MinIO console server and use the credentials provided in the service details "Environment Variables"
- Create a bucket `windmill-instance-storage`
- Create an access key and secret key in the MinIO console server "Access Keys" setting and copy them
- Click "Create"
- Go to the Windmill "instance settings" and in the "Core" tab, set the "Instance Objext Storage" to "S3" and add
  -  Bucket: `windmill-instance-storage`
  -  Access Key ID: `access key id`
  -  Secret Access Key: `secret access key`
  -  Region: `region`
  -  Endpoint: `<minio server url>:9000`
  -  Allow http: `true`
- Click "Test from a server" and "Test from a worker" and make sure they both succeed
- Click "Save"
 

## NOTES

- SMTP server will not be supported
