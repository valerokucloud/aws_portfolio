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

### What is the maximum size of an item in DDB?
The maximum item size in DDB is 400 KB. That includes:
 * The sum of all attribute names and values (binary or text).
 * The UTF-8 length of strings.
 * The length of binary data.
 * Any overhead for attribute names and types.

### Capacity modes availables for DDB:

1. Provisioned Capacity Mode:
 * You specify the number of read capacity units (RCUs) and write capacity units (WCUs) required.
 * Best suited for predictable, steady workloads.
 * You can also enable Auto Scaling, which automatically adjusts capacity based on utilization.
 * Cost-effective if your workload is stable and you can estimate traffic.

2. On-demand Capacity Mode:
 * You don’t need to specify RCUs or WCUs.
 * DynamoDB automatically scales up and down to handle requests.
 * You pay per request (read/write request units).
 * Best for unpredictable or spiky workloads, or if you want to start without capacity planning.

### What are Write Capacity and Read Capacity Units (WCU/RCU)?

1. Write Capacity Units (WCU):
 *  1 WCU = One write per second for an item up to 1 KB in size.
 * If the item is larger than 1 KB, multiple WCUs are consumed.
  * Example: Writing a 2.5 KB item = 3 WCUs.
    
2. Read Capacity Units (RCU):
Reads depend on whether they’re eventually consistent or strongly consistent:
 * 1 RCU =
  * One strongly consistent read per second for an item up to 4 KB, OR
  * Two eventually consistent reads per second for an item up to 4 KB.
  * If the item is larger than 4 KB, more RCUs are consumed.
  * Example: Reading a 10 KB item strongly consistent = 3 RCUs.





## References 
* [Create a billing alarm to monitor your estimated AWS charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html)
 

## Output:

![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Beginner/1.%20Create%203%20alarms/alarms.PNG)
