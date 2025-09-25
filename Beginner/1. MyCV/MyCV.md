# 1. MyCV (static website using S3)
 
## Difficulty: Beginner

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 

### Steps: 


1. Create an S3 bucket
    * Enable static website hosting
    * Create read access policy
    * Put the three files: index.html, index.css and avatar.png.


2. Using CloudFront to distribute the content.
    *   Create a CloudFront distribution:
        *   Set the Origin domain to the bucket we have created before + change the access from Public to Origin Access.
        *   Create a new OAC with the default settings.
        *   Don't enable Web Application Firewall (WAF) options.
        *   Update the Bucket policy to allow CloudFront service to access the resources inside the bucket.
        *   Save changes and wait until the CloudFront status is set to enabled.
        *   Test the distribution by adding '/index.html' to the end of the URL.


3. (Optional) - Monitoring the website through CloudWatch alarms in CloudFront:
    *   Select "Per Distribution Metrics".
        *   In this case the relevants are: BytesDownloaded, Requests, 5xxErrorRate and 4xxErrorRate.
                            

4. (Optional) - Implementing custom DNS with Route 53. It would be easier for you and others to remember if your URL was something like "thebestCV.com".
    *   Register a new domain using Route 53.
        *   Create a DNS record inside your domain under "hosted zones".
        *   Create a certificate through AWS Certificate Manager to support that naming (["thebestCV.com"]).
          
6. (Optional) - Security.
    *   (CloudFront). Applying features through AWS Web Application Firewall: https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html
    *   AWS Shield: managed DDoS protection service.It has two offerings: Standard and Advanced. https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html 


## References 
* [Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
* [Using Amazon CloudWatch alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
* [Configuring Amazon Route 53 as your DNS service](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-configuring.html)
* [Using AWS WAF with Amazon CloudFront](https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html)
* [AWS Shield mitigation logic for CloudFront and Route 53](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-event-mitigation-logic-continuous-inspection.html)
 

## Principal Architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Beginner/1.%20MyCV/principal_arch.png)


## Future work Architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Beginner/1.%20MyCV/Final_arch.png)
