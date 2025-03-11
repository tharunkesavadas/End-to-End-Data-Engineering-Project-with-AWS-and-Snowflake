# Spotify End-to-End- Data Engineering Project with AWS and Snowflake

### My latest Data Engineering Project, where I designed and implemented a scalable ETL pipeline using AWS, Snowflake, Python, SQL and Power BI. This project automated data ingestion from the Spotify API, transformed it using AWS Lambda, and loaded it into Snowflake Data warehouse for analytics and visualization in Power BI.

* 1. Data Extraction (Extract Layer) 

- Utilized Python to extract track, artist, and playlist data from the Spotify API.
- Scheduled Amazon CloudWatch Events to trigger an AWS Lambda function daily for automated extraction.
- Stored raw JSON data in an Amazon S3 bucket (Raw Data Zone).

* 2. Data Transformation (Transform Layer)

- Implemented another AWS Lambda function to process and clean the extracted data.
- Performed data normalization, schema mapping, and aggregations to ensure compatibility with Snowflake.
- Stored transformed data in a separate Amazon S3 bucket (Processed Data Zone).
- Used Amazon S3 Object Put triggers to initiate the transformation process upon data arrival.

* 3. Data Loading & Warehousing (Load Layer)

- Leveraged Snowpipe for continuous ingestion of transformed data from Amazon S3 into Snowflake tables.
- Defined a Snowflake stage and file format to seamlessly parse JSON data.
- Utilized SQL and used COPY INTO command within Snowpipe to load data incrementally into Snowflake tables without manual intervention.
- Configured Amazon S3 Event Notifications to publish events to an SNS topic, which then triggered Snowpipe for real-time data loading.

* 4. Data Visualization

- Connected Snowflake to Power BI to generate real-time reports on streaming trends, top artists, and user engagement.
- Created interactive dashboards to track song popularity, user listening behavior, and playlist trends.

