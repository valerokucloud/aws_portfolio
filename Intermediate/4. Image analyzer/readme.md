# 4. Building an Image analyzer.
 
## Difficulty: Intermediate

## Project’s Author 
* This project was inspired by the book [**AWS Cloud Projects: Strengthen Your AWS Skills Through Practical Projects, from Websites to Advanced AI Applications**](https://www.packtpub.com/en-be/product/aws-cloud-projects-9781835889282) by Ivo Pinto and Pedro Santos.
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

<br>

## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 

## Architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/Architecture/principal_arch.png)
<br>

### Steps: 
<br>

**1. Local architecture definition**
* Defined a centralized local configuration describing the full infrastructure architecture.
* Declared Lambda functions, IAM roles, permissions, and API routes in a single structure.
* Enabled dynamic resource creation using Terraform for_each.
* Designed the infrastructure to be scalable and easily extendable.
<br>

**2. S3 bucket creation**
* Created an S3 bucket to store uploaded images.
* Configured the bucket with public access blocked for security.
* Used the bucket as storage backend for application uploads.
<br>

**3. IAM role creation**
* Created an execution role for Lambda functions.
* Configured trust policy allowing Lambda service to assume the role.
* Established secure permission boundaries for serverless resources.
<br>

**4. IAM policy assignment**
* Generated IAM policies dynamically based on each Lambda’s needs.
* Applied least-privilege permissions for each function.
* Granted CloudWatch logging permissions.
* Added Rekognition permissions only to the analysis function.
* Attached policies to the execution role.
<br>

**5. Lambda packaging (.py files)**
* Automatically packaged Python source files into ZIP archives.
* Generated hashes to detect code changes.
* Prepared deployment artifacts dynamically during Terraform execution.
<br>

**6. API GW creation**
* Provisioned an HTTP API Gateway.
* Configured API name and endpoint type.
* Established public entry point for backend services.
<br>

**7. API integration setup**
* Connected API routes to corresponding Lambda functions.
* Used AWS_PROXY integration to forward full HTTP requests.
* Enabled seamless communication between API Gateway and Lambdas.
<br>

**8. (API GW) Route configuration**
* Created API routes dynamically from local configuration.
* Defined endpoints:
* GET endpoint for upload URL generation
* POST endpoint for image analysis
* Linked each route to its correct Lambda integration.
<br>

**9. Lambda Invocation Permissions**
* Granted API Gateway permission to invoke Lambda functions.
* Scoped permissions to specific API execution ARNs.
* Ensured secure service-to-service invocation.
<br>

**10. Deployment stage configuration**
* Created default API Gateway stage.
* Enabled automatic deployment of changes.
* Ensured updates are published immediately after Terraform apply.
<br>

**11. Output exposure**
* Exported API endpoint URL as Terraform output.
* Simplified testing and external integration.
<br>

**12. Application testing**
* Validated the API by sending HTTP requests directly to the API Gateway endpoint.
* Tested presigned URL generation endpoint (in our case we used W11 Powershell):

curl.exe -X GET https://YOUR_API_ID.execute-api.REGION.amazonaws.com/upload-url

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/App%20test/1.png)
<br>

* Save into '$URL' variable the value for 'uploadUrl'.
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/App%20test/2.png)
<br>


* Uploaded an image using the returned presigned URL:

curl.exe -X PUT -H "Content-Type: image/jpeg" --upload-file goodphoto.jpeg "$URL" 

* Save into 'body.json' the content of 'fileKey' variable to avoid parsing problems with double quotes:
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/App%20test/filekey.png)
<br>

* Tested image analysis endpoint:

curl.exe -X POST https://x0mel1aadb.execute-api.eu-south-2.amazonaws.com/analyze 
-H "Content-Type: application/json" -d "@body.json"  


* Verified correct system behavior:
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/4.%20Image%20analyzer/App%20test/4.png)
<br>

* Upload URL generated successfully (image stored in S3 bucket).
* Rekognition returned detected faces and emotions.


<br>

## Result
* Fully serverless AWS backend architecture.
* Secure direct image uploads to S3 using presigned URLs.
* Automated face detection and emotion analysis with Rekognition.
* Public HTTP API endpoint powered by API Gateway and Lambda.
* Scalable and cost-efficient event-driven design.
* Infrastructure fully reproducible using Terraform.


## References
- [Using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)<br>
- [Uploading objects with presigned URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/PresignedUrlUploadObject.html)<br>
- [Using Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)<br>
- [Using AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)<br>
- [Using Amazon Rekognition](https://docs.aws.amazon.com/rekognition/latest/dg/what-is.html)<br>
- [Using AWS Identity and Access Management (IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)<br>
 
<br>

