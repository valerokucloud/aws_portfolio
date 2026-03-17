# 1. MyCV (static website using S3)
 
## Difficulty: Intermediate

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 ## Project overview: showcase of your skills, experience and accomplishments to potential employers or clients. 
This project demonstrates how to deploy a personal CV website using Amazon S3 for static hosting and Amazon CloudFront for global content delivery. It showcases a scalable, secure, and highly available architecture that can be enhanced with monitoring, custom DNS through Route 53, and additional security features such as AWS WAF and AWS Shield.
<br>

## Tech Stack
- Amazon S3 (Static Website Hosting)
- Amazon CloudFront (Content Delivery Network)
- Amazon Route 53 (DNS and Domain Management) – Optional
- AWS Certificate Manager (SSL/TLS Certificates) – Optional
- Amazon CloudWatch (Monitoring and Alarms) – Optional
- AWS WAF (Web Application Firewall) – Optional
- AWS Shield (DDoS Protection) – Optional
<br>

## Basic architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/principal_arch.png)
<br>

## Actual architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/Final_arch.png)
<br>

## Best Practices

- Avoid making the S3 bucket publicly accessible by using CloudFront Origin Access Control (OAC).
- Use CloudFront to improve performance through global edge caching and reduce latency.
- Enable HTTPS using AWS Certificate Manager to ensure secure communication.
- Implement monitoring with Amazon CloudWatch metrics and alarms to detect errors or unusual traffic patterns.
- Protect the application using AWS WAF and AWS Shield to mitigate common web attacks and DDoS threats.
- Use Route 53 for reliable DNS management and easier domain configuration.
<br>

## Deployment: 

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
        *   Create DNS records inside your domain under "hosted zones". One for the alias (thebestCV.com) and another for www (www.thebestCV.com).
        *   Create a certificate through AWS Certificate Manager to support that naming (["thebestCV.com"]).
          
6. (Optional) - Security.
    *   (CloudFront). Applying features through AWS Web Application Firewall: https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html
    *   AWS Shield: managed DDoS protection service.It has two offerings: Standard and Advanced. https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html 
<br>

## Project Results

* Successfully deployed a personal CV website using Amazon S3 for static hosting.
* Improved website performance and global availability through Amazon CloudFront distribution.
* Implemented a scalable and highly available architecture using fully managed AWS services.
* (Optional) Added monitoring with Amazon CloudWatch to track traffic and error metrics.
* (Optional) Enabled custom domain configuration using Route 53 and AWS Certificate Manager.
* (Optional) Enhanced security using AWS WAF and AWS Shield to protect against common web threats.


## References 
*[Hosting a static website using Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
*[Using Amazon CloudWatch alarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html)
*[Configuring Amazon Route 53 as your DNS service](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-configuring.html)
*[Using AWS WAF with Amazon CloudFront](https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html)
*[AWS Shield mitigation logic for CloudFront and Route 53](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-event-mitigation-logic-continuous-inspection.html)
 

## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/Output.png)
