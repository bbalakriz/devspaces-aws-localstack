# Build custom image for localstack using the Dockerfile 
This is required as the permissions for the /.cache folder in the default localstack image is owned by root and containers running on OpenShift are non root. 

```
podman build -t quay.io/balki404/localstack:stable .
```

# Using the custom localstack image as a container in the workspace pod. 
The devfile contained in this repository uses the custom built container image from the given Dockerfile. 

Once the workspace gets launched with this devfile, do the following to test localstack. 

```
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
./awscli-bundle/install -b ~/bin/aws

alias aws="aws --endpoint-url=http://localhost:4566"
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

aws s3api list-buckets
aws s3api create-bucket --bucket my-temp-bucket-12345 --region us-east-1

echo "This is a temporary file for testing S3 upload" > temp-file.txt
aws s3 cp temp-file.txt s3://my-temp-bucket-12345/
aws s3 ls s3://my-temp-bucket-12345/

```

OR

```
pip install awscli-local
awslocal s3 mb s3://mysamplebucket
```