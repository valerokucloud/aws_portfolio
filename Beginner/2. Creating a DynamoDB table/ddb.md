# 2. Creating three billing alarms through CloudWatch
 
## Difficulty: Beginner

## Project’s Author 
* [Antonio Valero](https://www.linkedin.com/in/avalero89/) 

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 

### You need to complete the following:

  *   Create a DynamoDB table with previsioned capacity.
  *   Test it by inserting random data.
  *   Run a scan on the table that returns all three items.
  *   Run a query on the table that returns a single item.


### What is an "item" in DynamoDB?
An item in DynamoDB (DDB from now on) is a single record in a table, which is composed of attribtutes. Each item is uniquely identified by a primary key and can hold different types of data within its attributes.

### What data types can you store in a DDB table?
  * Scalar types: String, Number, Binary, Boolean and Null.
  * Set types: String Set, Number Set and Binary Set.
  * Document types: List and Map.  


3. In the navigation panel, choose "Billing" and create the alarm.
    *   You can adapt your alarm to the threshold type, currency type, EstimatedCharges, and the type of evaluation that may occur before “declaring” it.
    *   Configure actions: what type of trigger is needed, linking it to an SNS topic or linking it to others (Lambda Action, Auto Scaling action, Systems Manager action...).
        *   Link it to an SNS topic and provide an email address.
    *   Set the alarm name.
    *   Confirm the SNS topic subscription (only if it has been specifically created for that purpose).


## References 
* [Create a billing alarm to monitor your estimated AWS charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html)
 

## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Beginner/1.%20Create%203%20alarms/alarms.PNG)
