# 2. Creating a DynamoDB table
 
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


### Does DDB support autoscaling?
DynamoDB supports auto scaling by automatically adjusting the provisioned read and write capacity units (RCUs/WCUs) of a table or a global secondary index so that your application gets enough throughput without you constantly tweaking settings.

More info: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/AutoScaling.html 


### Does DynamoDB support encryption?
Amazon DynamoDB supports encryption to protect your data at rest and in transit.

More info: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/data-protection.html


### Which key type is required for creating a table?
When you create a DynamoDB table, you must define a primary key — this is required because DynamoDB uses it to uniquely identify and partition items.
There are two types of primary keys you can choose:
 1. Partition Key (Simple Primary Key)
 2. Partition Key + Sort Key (Composite Primary Key)

More info: https://aws.amazon.com/es/blogs/database/choosing-the-right-dynamodb-partition-key/ 


### Which three data types does the Primary Key support?
In Amazon DDB, the Primary Key attributes (Partition Key and optional Sort Key) can only be of three scalar data types:
1. String: UTF-8 encoded text, up to 2048 bytes for a partition key and 1024 bytes for a sort key.
2. Number: can be integer, float, or any numeric type (stored as variable length, up to 38 digits of precision).
3. Binary: arbitrary binary data, such as encoded images or compressed files (up to the same size limits as above).


### What is the difference between a Primary (Hash) Key and a Secondary (Sort) Key?
Primary Key (Hash Key): the primary key is what uniquely identifies each item in a table. It can be defined in two ways:
 * Also called the partition key.
 * A single attribute that DynamoDB uses to determine the partition (physical storage location) of an item.
 * Every item in the table must have a unique partition key value.
 * Example:
  If UserID is the partition key, then each user must have a unique UserID.
With only a partition key (called a simple primary key), you can only store one item per partition key value.
 
 
 Secondary Key (Sort Key):
 * Also called the range key.
 * When combined with the partition key, it forms a composite primary key.
 * Multiple items can share the same partition key but must have a unique sort key within that partition.
 * The sort key allows items with the same partition key to be sorted and queried efficiently.
 * Example:
  If your table’s primary key is (UserID, OrderDate), multiple orders can belong to the same UserID, and you can query them by date range.

| Feature           | Primary (Hash) Key (Partition Key)                | Secondary (Sort) Key (Range Key)                             |
| ----------------- | ------------------------------------------------- | ------------------------------------------------------------ |
| **Purpose**       | Decides the partition (physical location of data) | Provides uniqueness within partition and ordering            |
| **Uniqueness**    | Must be unique if used alone                      | Must be unique **per partition key**                         |
| **Query support** | Look up items directly by key                     | Enables range queries, sorting, filtering within a partition |
| **Structure**     | Single attribute                                  | Optional second attribute                                    |



### What is a DynamoDB Stream?
A DynamoDB Stream is a feature in Amazon DynamoDB that lets you capture and react to real-time changes in your table’s data.
Think of it as a change log for your table.

More info: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/streamsmain.html


### What are Global Tables?
Global Tables provide a fully replicated, multi-region solution for DynamoDB tables. This allows for automatic data replication across multiple AWS Regions, providing high availability and low-latency access to data from any location.

More info: https://aws.amazon.com/es/dynamodb/global-tables/


### How do backups work in DynamoDB?
DynamoDB offers on-demand backups and point-in-time recovery (PITR) backups to help protect your DynamoDB data from disaster events and offers data archiving for long-term retention. You can back up tables from a few megabytes to hundreds of terabytes of data, with no impact on performance and availability to your production applications. All backups are automatically encrypted, cataloged, and easily discoverable.

With on-demand backups, you can create a snapshot backup of your table that DynamoDB stores and manages. You're charged based on the size and duration of your backups. Using on-demand backup, you can restore your entire DynamoDB table to the exact state it was in when the backup was created.

More info: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Backup-and-Restore.html 


### Can DynamoDB be performant at-scale?

 * Low Latency: Single-digit millisecond reads/writes, predictable at any size.
 * Scalability:
   * Partitioning: Data auto-distributed across partitions.
   * Auto Scaling & Adaptive Capacity: Adjusts throughput and handles hot partitions.
   * Global Tables: Multi-Region replication for global users.
 * Optimizations:
   * DAX (in-memory caching) for microsecond reads.
   * Streams + Lambda for event-driven architectures.
   * S3 Export for analytics.
 * Best Practices:
   * Design partition keys carefully (avoid hot keys).
   * Store large objects in S3.
   * Use GSIs for flexible queries.

More info: https://aws.amazon.com/es/blogs/database/amazon-dynamodb-auto-scaling-performance-and-cost-optimization-at-any-scale/ 


## Output:


