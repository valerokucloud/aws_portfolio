# 1. Creating three billing alarms through CloudWatch
 
## Difficulty: Beginner

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 

### Steps: 


1. Set your Region to US East (N.Virginia). Billing metric data is stored in this Region and represents worldwide charges.


2. In the navigation panel, choose "Billing" and create the alarm.
    *   You can adapt your alarm to the threshold type, currency type, EstimatedCharges, and the type of evaluation that may occur before “declaring” it.
    *   Configure actions: what type of trigger is needed, linking it to an SNS topic or linking it to others (Lambda Action, Auto Scaling action, Systems Manager action...).
        *   Link it to an SNS topic and provide an email address.
    *   Set the alarm name.
    *   Confirm the SNS topic subscription (only if it has been specifically created for that purpose).


## References 
* [Create a billing alarm to monitor your estimated AWS charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html)
 

## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/edit/main/Beginner/alarms.PNG)

