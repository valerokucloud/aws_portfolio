# 3. Building a Serverless Recipe-Sharing Application
 
## Difficulty: Intermediate

## Project’s Author 
* This project was inspired by the book [**AWS Cloud Projects: Strengthen Your AWS Skills Through Practical Projects, from Websites to Advanced AI Applications**](https://www.packtpub.com/en-be/product/aws-cloud-projects-9781835889282) by Ivo Pinto and Pedro Santos.
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 


 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 

### Steps: 

**1. S3 Buckets Creation**
* Created an S3 bucket to host the frontend static website.
* Enabled static website hosting.
* Applied read access policy for content delivery.
* Uploaded frontend assets (HTML, CSS, images).
* Created an additional S3 bucket to store application assets (e.g. recipe images).
<br>

**2. CloudFront Distribution**
* Created a CloudFront distribution.
* Configured the frontend S3 bucket as the origin.
* Enabled Origin Access Control (OAC).
* Updated the S3 bucket policy to allow CloudFront access.
* Validated the distribution once the status was set to *Enabled*.
<br>

**3. DynamoDB Table**
* Created a DynamoDB table to store recipes data.
* Defined the primary key structure.
* Configured billing mode for scalability.
* Prepared the table for Lambda integration.
<br>

**4. Cognito User Authentication**
* Created an Amazon Cognito User Pool.
* Configured user authentication and authorization settings.
* Prepared Cognito to secure backend API endpoints.
<br>

**5. IAM Roles and Policies**
* Created IAM roles for Lambda execution.
* Attached policies allowing access to:
  * DynamoDB
  * S3
  * CloudWatch Logs
* Applied the principle of least privilege.
<br>

**6. Lambda Functions**
* Created multiple AWS Lambda functions to handle backend logic:
  * Authentication
  * Health check
  * Get recipes
  * Create recipe
  * Delete recipe
  * Like recipe
* Configured runtime, permissions, and environment variables.
<br>

**7. API Gateway**
* Created an Amazon API Gateway REST API.
* Defined resources and HTTP methods.
* Integrated each endpoint with its corresponding Lambda function.
* Enabled Cognito authorization for protected routes.

<br>

## Result
* Fully serverless AWS infrastructure.
* Scalable and cost-efficient architecture.
* Static frontend delivered globally through CloudFront.
* Infrastructure fully reproducible using Terraform.


## References
-[Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)<br>
-[Using Amazon CloudFront](https://docs.aws.amazon.com/cloudfront/)
-[Using Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
-[Using AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
-[Using Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/)
-[Using Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/)
-[Using AWS Identity and Access Management (IAM)](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

 
<br>

## Architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/3.%20Recipe%20Web%20Application/Architecture/principal_arch.png)

<br>

## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/3.%20Recipe%20Web%20Application/Architecture/output.png)
