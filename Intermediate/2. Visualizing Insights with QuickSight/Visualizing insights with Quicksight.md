# 2. Visualizing Insights with QuickSight
 
## Difficulty: Intermediate

## Project’s Author 
* [Kevin-byt](https://github.com/Kevin-byt)
* [Kevin's LinkedIn](https://www.linkedin.com/in/kevin-kiruri/)

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 
In today's data-driven landscape, transforming raw data into meaningful insights is crucial. **AWS QuickSight** and **Amazon S3** provide a powerful combination for building scalable, interactive data visualizations directly from your cloud-stored data.

This guide explores how to connect, prepare, and visualize your datasets using these AWS services. Whether you're a **data analyst**, **developer** , or **business leader** , you'll learn how to leverage QuickSight to create compelling dashboards and make data-driven decisions with ease.


### Steps: 

1. **Data Source**: begin by obtaining your dataset. For example, you can use Spotify data on artists and listeners, which is available on platforms like Kaggle.(https://www.kaggle.com/datasets)
2. **Creating an S3 bucket and uploading data:** set up an S3 bucket, upload dataset files (listeners.csv and listeners.json) and configure the manifest file.
     * Terraform can't modify a physical JSON file directly, but it can generate one dynamically before uploading it, using jsonencode() or templatefile(). In our case we used templatefile().
       * Therefore, the manifest file "listeners.json" will be renamed "listeners.json.tpl" (temporary file) so that it can be uploaded to the s3 bucket with the bucket's name changed. 
4. Setting up AWS QuickSight
5. Visualize your data on AWS QuickSight
6. Deeping dive into Quicksight (additional)


## References 
 

## Basic architecture:


## Actual architecture:


## Output:

