# 2. Visualizing Insights with QuickSight
 
## Difficulty: Intermediate

## Project’s Author 
* [Kevin-byt](https://github.com/Kevin-byt)
* [Kevin's LinkedIn](https://www.linkedin.com/in/kevin-kiruri/)

 
## Project applications: showcase of your skills, experience and accomplishments to potential employers or clients. 
 
In today's data-driven landscape, transforming raw data into meaningful insights is crucial. **AWS QuickSight** and **Amazon S3** provide a powerful combination for building scalable, interactive data visualizations directly from your cloud-stored data.

This guide explores how to connect, prepare, and visualize your datasets using these AWS services. Whether you're a **data analyst**, **developer** , or **business leader** , you'll learn how to leverage QuickSight to create compelling dashboards and make data-driven decisions with ease.

<br>

## Tech Stack

- Amazon S3 – Data storage for datasets and manifest files
- Amazon QuickSight – Data visualization and dashboard creation
- Terraform – Infrastructure provisioning and automation
- Kaggle – External dataset source
- JSON / CSV – Data formats for ingestion and analysis
<br>

## Architecture:
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Architecture/Architecture.png)
<br>

## Best Practices

- Store datasets in Amazon S3 to ensure scalable, durable, and highly available data storage.
- Use manifest files to clearly define data sources and formats when connecting Amazon QuickSight to S3 datasets.
- Automate infrastructure provisioning with Terraform to ensure reproducibility and consistent environment configuration.
- Apply proper permission management so that Amazon QuickSight can securely access the required S3 buckets.
- Perform data preparation and validation before visualization to ensure data quality and accurate analytics.
- Design clear and interactive dashboards that highlight key insights and allow users to explore the data effectively.
<br>

## Deployment 

1. **Data Source**: begin by obtaining your dataset. For example, you can use Spotify data on artists and listeners, which is available on platforms like [Kaggle](https://www.kaggle.com/datasets)
2. **Creating an S3 bucket and uploading data**: set up an S3 bucket, upload dataset files (listeners.csv and listeners.json) and configure the manifest file.
   * Terraform can't modify a physical JSON file directly, but it can generate one dynamically before uploading it, using jsonencode() or templatefile(). In our case we used templatefile().
     * Therefore, the manifest file "listeners.json" will be renamed "listeners.json.tpl" (temporary file) so that it can be uploaded to the s3 bucket with the bucket's name changed
       <br><br>
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/manifest_file.PNG)
       
3. **Setting up AWS QuickSight**:
   * Creating a new user (in our case we used the free one month version).
   * Check bucket permissions using the options at the top right and selecting "Permissions" + S3 + selecting the bucket: <br><br>
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/Permissions.PNG) <br><br>
   * Define a new datasource --> select S3 and define the S3 URI of the manifest file:<br><br>
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/1.PNG) <br><br>
   * Once this is done, we will have the dataset defined and can begin with data visualization: <br><br>
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/2.PNG) <br><br>
4. **Visualizing data on AWS QuickSight**:
  * Select the data source details and click on "Visualize": <br><br>
   ![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/3.PNG) <br><br>

  * Define an interactive sheet for visualize the data: <br><br>
   ![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/4.PNG)

  * Select the following:
    * Artist field
    * Filter (more than 75.000.000 listeners, for example)
    * Select a visual chart <br><br>
     
![Imagen](https://github.com/valerokucloud/aws_portfolio/blob/main/Intermediate/2.%20Visualizing%20Insights%20with%20QuickSight/Quicksight%20config/5.PNG)

<br><br>
5. **Deeping dive into Quicksight (additional)**
<p align="justify">
  AWS QuickSight offers a wide range of features for data visualization and analysis. Here are some key features that you can practice and explore:

1. **Data source connectivity**: Amazon QuickSight provides robust capabilities for connecting to a wide range of data sources, both on-premises and cloud-based. Supported sources include Amazon S3, Amazon RDS, Amazon Redshift, Microsoft SQL Server, among others. It is essential to practice configuring connections to various data sources in order to efficiently import datasets into the QuickSight analytics environment. <br>
2. **Data preparation**: QuickSight includes built-in functionalities for data cleansing, transformation, and modeling. These capabilities support operations such as filtering, pivoting, and data aggregation. Proper data preparation is critical to ensure data quality and relevance for subsequent visualization and analytical tasks. <br>
3. **Interactive dashboards**: the platform enables the creation of interactive dashboards by combining multiple visualizations into a single visual interface. Dashboard design should focus on clearly communicating key insights while enabling end-users to dynamically explore the data to support informed decision-making. <br>
4. **Custom calculations**: QuickSight features a formula editor that allows users to create custom calculated fields. These calculations can be used to derive additional metrics, perform data segmentation, or transform variables—enabling more in-depth and business-specific analysis. <br>
5. **Usage and Performance Monitoring**: QuickSight provides tools for monitoring the usage and performance of deployed dashboards and analyses. Continuous monitoring helps identify bottlenecks, optimize queries, and efficiently scale the infrastructure—ensuring a smooth user experience and sustainable operation of the analytics environment.
</p>
<br>

## Project Results

* Successfully stored and managed dataset files in Amazon S3 to enable scalable and reliable data access.
* Connected Amazon QuickSight to the S3 dataset using a manifest file to create a structured data source.
* Built interactive visualizations to analyze artist popularity based on listener metrics.
* Demonstrated how to transform raw dataset files (CSV/JSON) into meaningful visual insights.
* Implemented an automated infrastructure setup using Terraform to improve reproducibility and deployment efficiency.
<br>

## References 

* [Amazon QuickSight Overview](https://docs.aws.amazon.com/quicksight/latest/developerguide/welcome.html?)
* [Managing user access inside Amazon Quick Suite](https://docs.aws.amazon.com/quicksuite/latest/userguide/managing-users.html?)
* [Getting started with Amazon QuickSight](https://docs.aws.amazon.com/quicksuite/latest/userguide/quick-sight-getting-started.html?)
* [Preparing data in Amazon QuickSight](https://docs.aws.amazon.com/quicksuite/latest/userguide/preparing-data.html?)
<br> 
