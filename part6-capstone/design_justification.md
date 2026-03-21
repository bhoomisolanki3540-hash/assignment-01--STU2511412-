## Storage Systems

To meet the hospital's four goals, I have implemented a **Polyglot Persistence** strategy:

1.  **Readmission Risk (Data Warehouse):** I chose a **Star Schema in a Data Warehouse** for historical treatment data. Predictive models for readmission require "clean" historical features (age, previous visits, diagnosis codes). A warehouse allows for high-performance aggregation of this structured data.
2.  **Plain English Queries (Vector Database):** I implemented a **Vector Database** to store patient history embeddings. Traditional SQL cannot handle the semantic "meaning" of a doctor's question. By converting patient notes into vectors, an LLM can perform semantic searches to find relevant cardiac events even if the specific word "cardiac" isn't in the exact record.
3.  **Monthly Management Reports (RDBMS/OLAP):** I used the **Star Schema** (Dimension: Date, Department, Bed Type; Fact: Occupancy, Cost) to ensure management gets "one version of the truth" for their reports.
4.  **Real-Time Vitals (Data Lake):** ICU monitoring devices generate high-velocity, high-volume data. I chose a **Data Lake** (Parquet files) to "stream and store" this raw data. It is too bulky for a standard database but perfect for a Lakehouse where it can be analyzed later for patterns.

## OLTP vs OLAP Boundary

In this design, the **OLTP (Online Transactional Processing)** boundary exists at the **Electronic Health Record (EHR) system**. This is where doctors enter active treatments and nurses update vitals. These systems prioritize **write-speed** and **data integrity** (ACID).

The **OLAP (Online Analytical Processing)** boundary begins at the **ETL/ELT pipeline**. Data is extracted from the EHR and ICU monitors, cleaned, and loaded into the **Data Warehouse and Vector DB**. Once the data crosses this line, it is no longer being "edited"; it is being "read" for patterns, predictions, and management insights.

## Trade-offs

A significant trade-off in this design is **System Complexity vs. Performance**. By using four different storage systems (SQL, NoSQL/Lake, Warehouse, and Vector DB), we increase the operational burden on the hospital's IT staff. They must manage multiple sets of permissions, backups, and synchronization pipelines.

**Mitigation:** To mitigate this, I would implement a **Data Lakehouse** (like Databricks or Snowflake) that can handle both the raw vitals (Lake) and the structured reporting (Warehouse) in a single platform. This reduces the "moving parts" while still allowing for specialized AI and analytical workloads.
