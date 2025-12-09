
# *README.md — Healthcare Symptoms & Disease Analysis (Big Data Project)* 


# Healthcare Symptoms & Disease Analysis – Big Data Project  
### Databricks (Free Edition) | PySpark | Spark SQL | Lakeview Dashboards

---

##  1. Project Overview

This project analyzes patient symptom records to understand:

- Disease frequency patterns  
- How symptoms relate to specific diseases  
- Age & gender distribution of illnesses  
- Which symptoms are most associated with high symptom counts  

Using **Databricks Free Edition**, **PySpark**, **Spark SQL**, and **Lakeview Dashboards**, this project demonstrates a full Big Data workflow:

- Data ingestion  
- Cleaning & feature engineering  
- Exploratory analysis  
- KPI-based dashboard design  
- Global filters for interactive insights  

The dataset simulates real-world health records and is ideal for public health analysis.

---

##  2. Dataset Description

Source file: `Healthcare.csv`

### Columns
| Column | Description |
|--------|-------------|
| patient_id | Unique patient identifier |
| Age | Age of the patient |
| Gender | Male/Female/Other |
| Symptoms | Comma-separated list of symptoms reported |
| Symptom_count | Number of symptoms |
| Disease | Diagnosed disease |

---

##  3. Technologies Used

- Databricks Free Edition  
- PySpark DataFrames  
- Spark SQL  
- Lakehouse storage  
- Databricks Lakeview for dashboards  
- GitHub for documentation  

---

##  4. Data Pipeline

### 4.1  Ingestion
Performed in: `01_ingest_and_clean_healthcare.ipynb`

Steps:
1. Uploaded `Healthcare.csv` into Databricks  
2. Created table:



final_exam_cluster.default.raw_healthcare

`

---

### 4.2  Cleaning & Feature Engineering

Performed in the same notebook.

Key transformations:

#### ✔ Convert columns to correct types

df = (
    df_raw
    .withColumn("Age", col("Age").cast("int"))
    .withColumn("Symptom_count", col("Symptom_count").cast("int"))
)
`

#### ✔ Create age groups

df = df.withColumn(
    "age_group",
    when(col("Age") < 18, "Child")
    .when(col("Age") < 35, "Young Adult")
    .when(col("Age") < 60, "Adult")
    .otherwise("Senior")
)


#### ✔ Standardize gender formatting

df = df.withColumn(
    "Gender",
    initcap(col("Gender"))
)


#### ✔ Extract primary symptom (first listed)

df = df.withColumn(
    "primary_symptom",
    split(col("Symptoms"), ",")[0]
)


Cleaned table saved as:


final_exam_cluster.default.clean_healthcare


All dashboard tiles & filters use this dataset to allow *global filtering*.

---

##  5. Exploratory Data Analysis

Performed in: `02_analysis_notebook.ipynb`

### 5.1 PySpark Insights

####  Disease frequency


df.groupBy("Disease").count().orderBy(col("count").desc()).show()


####  Average symptom count by disease

df.groupBy("Disease").agg(avg("Symptom_count")).show()


####  Gender distribution per disease

df.groupBy("Disease", "Gender").count().show()


#### 🔹 Most common primary symptoms

df.groupBy("primary_symptom").count().orderBy(col("count").desc()).show()


---

### 5.2 SQL Insights (`sql_queries.sql`)

#### 1️ Top diseases by patient count

sql
SELECT Disease, COUNT(*) AS patient_count
FROM final_exam_cluster.default.clean_healthcare
GROUP BY Disease
ORDER BY patient_count DESC;


#### 2️ Average symptom count by age group

sql
SELECT age_group, AVG(Symptom_count) AS avg_symptoms
FROM final_exam_cluster.default.clean_healthcare
GROUP BY age_group
ORDER BY avg_symptoms DESC;


#### 3️ Most common primary symptoms

sql
SELECT primary_symptom, COUNT(*) AS occurrences
FROM final_exam_cluster.default.clean_healthcare
GROUP BY primary_symptom
ORDER BY occurrences DESC;


---

##  6. Lakeview Dashboard

Dashboard name: **Healthcare Insights Dashboard**

###  TILE 1 – Top Diseases by Patient Count (Bar Chart)

* Datasource: `clean_healthcare`
* X-axis: `Disease`
* Y-axis: `COUNT(*)`
* KPI: Which diseases occur most frequently?

---

###  TILE 2 – Average Symptom Count by Age Group (Column Chart)

* Datasource: `clean_healthcare`
* X-axis: `age_group`
* Y-axis: `AVG(Symptom_count)`
* KPI: How symptom complexity varies by age group

---

###  TILE 3 – Most Common Primary Symptoms (Horizontal Bar)

* Datasource: `clean_healthcare`
* X-axis: `occurrences`
* Y-axis: `primary_symptom`
* KPI: Which symptoms are most common across patients?

---

##  7. GLOBAL Dashboard Filters

All tiles use the same datasource:


final_exam_cluster.default.clean_healthcare


So filters apply globally.

---

###  Filter 1 — Age Group

* Field: `age_group`
* Type: Dropdown
* Affects all tiles

###  Filter 2 — Gender

* Field: `Gender`
* Type: Dropdown
* Affects all tiles

###  Filter 3 — Disease

* Field: `Disease`
* Type: Dropdown
* Affects all tiles

---

## ▶ 8. How to Run This Project

1. Import the notebooks into Databricks
2. Attach to active cluster
3. Run:

   * `01_ingest_and_clean_healthcare.ipynb`
   * `02_analysis_notebook.ipynb`
   * `03_dashboard_notebook.ipynb` (if used)
4. Open Lakeview and create the dashboard
5. Add all tiles
6. Add all global filters
7. Save and publish dashboard

---

## 📁 9. Repository Structure


healthcare-bigdata-final/
│
├── 01_ingest_and_clean_healthcare.ipynb
├── 02_analysis_notebook.ipynb
├── 03_dashboard_notebook.ipynb
├── sql_queries.sql
└── README.md


---

## 🏁 10. Conclusion

This project demonstrates:

* How to process healthcare records using Big Data tools
* How symptom-level data relates to disease frequency
* How demographic factors influence disease and symptom severity
* How to create KPI-driven dashboards using Databricks
* How to apply global filters for real-time analytical slicing

The final dashboard provides actionable insights for public health teams and healthcare analysts.
