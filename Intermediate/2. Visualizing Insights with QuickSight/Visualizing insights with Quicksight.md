# 2. Visualizing Insights with QuickSight
 
## Difficulty: Intermediate

## Project’s Author 
* [Kevin-byt](https://github.com/Kevin-byt)), (https://www.linkedin.com/in/kevin-kiruri/)

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 
n today's data-driven landscape, transforming raw data into meaningful insights is crucial. AWS QuickSight and Amazon S3 provide a powerful combination for building scalable, interactive data visualizations directly from your cloud-stored data.

This guide explores how to connect, prepare, and visualize your datasets using these AWS services. Whether you're a data analyst, developer, or business leader, you'll learn how to leverage QuickSight to create compelling dashboards and make data-driven decisions with ease.

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
        *   Create DNS records inside your domain under "hosted zones". One for the alias (thebestCV.com) and another for www (www.thebestCV.com).
        *   Create a certificate through AWS Certificate Manager to support that naming (["thebestCV.com"]).
          
6. (Optional) - Security.
    *   (CloudFront). Applying features through AWS Web Application Firewall: https://docs.aws.amazon.com/waf/latest/developerguide/cloudfront-features.html
    *   AWS Shield: managed DDoS protection service.It has two offerings: Standard and Advanced. https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html 


## References 

 

## Basic architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/principal_arch.png)


## Actual architecture:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/Final_arch.png)


## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/1.%20MyCV/Output.png)
