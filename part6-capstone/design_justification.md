## Storage Systems

To meet the hospital's requirements for a modern, AI-driven data strategy, I have designed a **Polyglot Persistence** architecture. This approach ensures that each of the four core medical and operational goals is supported by a storage system specifically optimized for that data's unique velocity, volume, and structure.

1.  **Readmission Risk (Data Warehouse):** I selected a **Star Schema in a Data Warehouse** (such as Snowflake) for historical treatment records. Predicting readmission requires complex **feature engineering** on structured data like patient demographics, ICD-10 diagnosis codes, and past pharmacy fills. A columnar warehouse allows for high-performance aggregation across millions of rows, which is essential for training and running predictive ML models accurately.

2.  **Plain English Queries (Vector Database):** I implemented a **Vector Database** (e.g., Pinecone) to store patient history embeddings. Traditional SQL databases rely on **exact keyword matching**, which fails if a doctor asks about "cardiac events" while a record only mentions "myocardial infarction." By converting clinical notes into high-dimensional vectors, a Large Language Model (LLM) can perform **semantic searches** that understand medical context, providing intuitive access to longitudinal patient history.

3.  **Monthly Management Reports (RDBMS/OLAP):** I utilized a **Star Schema** with dimension tables (Date, Department, Facility) and fact tables (Bed Occupancy, Operating Costs) to provide hospital leadership with "one version of the truth." This ensures that financial and operational KPIs are standardized, preventing discrepancies between different department spreadsheets.

4.  **Real-Time Vitals (Data Lake):** ICU monitoring devices generate high-velocity telemetry (EKG, SpO2). I chose a **Data Lake** using Parquet files for this "stream and store" requirement. This data is too bulky for a standard database but is perfect for a Lakehouse where it can be archived cheaply and analyzed later for long-term health patterns.

## OLTP vs OLAP Boundary

In this architecture, the **OLTP (Online Transactional Processing)** boundary is strictly maintained at the **Electronic Health Record (EHR) system**. This is the operational frontline where doctors enter active treatments. These systems are optimized for **write-speed** and **concurrency**, prioritizing **ACID** properties to ensure that life-critical data is never lost or corrupted during an update.

The **OLAP (Online Analytical Processing)** boundary begins at the **ETL/ELT pipeline**. Data is extracted from the EHR and ICU monitors, transformed into an analytical format, and loaded into the Data Warehouse and Vector DB. Once data crosses this line, it is treated as read-only. This separation ensures that a heavy management report does not consume the CPU resources needed by a doctor trying to save a patient's life in the ICU.

## Trade-offs

A significant trade-off in this design is **Architectural Complexity vs. Performance**. Using four distinct storage systems increases the operational burden on IT staff, who must manage multiple security permissions, backup strategies, and **Data Synchronization** schedules. 

**Mitigation:** To mitigate this, I would eventually move toward a **Data Lakehouse** unified platform. This reduces the "moving parts" while still allowing for specialized AI and analytical workloads.
