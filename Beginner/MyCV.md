# 1. MyCV (static website using S3) + Project title 
 

## Difficulty: Beginner

 

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 
## Objectives 

 

### Steps: 

1. Create an S3 bucket
    * Enable static website hosting
    * Put the three files: index.html, index.css and avatar.png.

2. (Optional) - Distribute the content using CloudFront:
    *   Create a CloudFront distribution.
        *   Set the Origin domain to the bucket we have created before + change the access from Public to Origin Access.
        *   Create a new OAC with the default settings.
        *   Don't enable Web Application Firewall (WAF) options.
        *   Update the Bucket policy to allow CloudFront service to access the resources inside the bucket.
        *   Save changes and wait until the CloudFront status is set to enabled.
        *   Test the distribution by adding '/index.html' to the end of the URL.


3. (Optional) - Monitoring the website through CloudWatch:
    *   Select "Per Distribution Metrics".
        *   In this case the relevants are: BytesDownloaded, Requests, 5xxErrorRate and 4xxErrorRate.
        *   We could add more 
            

(...) 

 

## References 
* [Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
 

## Project diagram 

(to review) 
