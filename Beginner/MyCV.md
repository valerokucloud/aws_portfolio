# 1. MyCV (static website using S3) + Project title 
 

## Difficulty 

Beginner

 

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 

## Objectives 

 

### Steps: 

1. Create an S3 bucket
    * Enable static website hosting
    * Put the three files (index.html, index.css and avatar.png)

2. (Optional) - Distribute the content via CloudFront:
    * Create a CloudFront distribution.
    *   Origin domain --> the bucket we have created before + change from Public to Origin Access.
    *   Create a new OAC with the default options.
    *   Web Application Firewall (WAF) options not enabled.
    *   Change the Bucket policy to allow the CloudFront service to access the resources inside your bucket.
    *   Accept changes and wait until the CloudFront status has been enabled.
    *   Test the distribution adding at the end '/index.html'.

3. 

(...) 

 

## References 
* [Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
 

## Project diagram 

(to review) 
