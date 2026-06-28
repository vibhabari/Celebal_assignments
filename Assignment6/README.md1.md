# Apache Spark Data Processing using PySpark

## Objective

To understand Apache Spark architecture and perform efficient data processing using PySpark. The assignment demonstrates data loading, schema handling, transformations, filtering, null handling, performance optimization concepts, and building a simple data pipeline using CSV and Parquet datasets.

---

## Dataset

**Superstore Dataset**

Formats used:
- CSV
- Parquet

---

## Tasks Performed

### 1. Spark Architecture
- Understood Driver, Cluster Manager, and Executors.
- Learned Spark execution modes.

### 2. Lazy Evaluation and DAG
- Explored how Spark delays execution until an action is called.
- Understood Directed Acyclic Graph (DAG) optimization.

### 3. Data Loading
- Loaded CSV dataset.
- Loaded Parquet dataset.
- Compared CSV and Parquet formats.

### 4. Schema Handling
- Viewed inferred schema.
- Learned explicit schema definition.

### 5. DataFrame Operations
- Selected required columns.
- Filtered records.
- Renamed columns.
- Cast data types.
- Added new columns.
- Handled null values.

### 6. Transformations and Actions
Transformations:
- select()
- filter()
- withColumn()
- withColumnRenamed()
- groupBy()
- orderBy()

Actions:
- show()
- count()
- first()
- take()
- printSchema()

### 7. Performance Concepts
- Lazy Evaluation
- DAG
- Narrow vs Wide Transformations
- Shuffle
- Predicate Pushdown
- CSV vs Parquet Performance

### 8. Data Pipeline
Implemented an ETL pipeline:

Read → Transform → Filter → Write

### 9. Output
Processed data was written to:
- CSV
- Parquet

---

## Folder Structure

```
project/
│
├── notebooks/
│   └── Spark_Assignment.ipynb
│
├── data/
│   ├── Superstore.csv
│   └── Superstore.parquet
│
├── output/
│   ├── processed_csv/
│   └── processed_parquet/
│
└── README.md
```

---

## Performance Insights

- Parquet performs faster than CSV because it stores data in a compressed columnar format.
- Predicate Pushdown reduces unnecessary disk reads when filtering Parquet files.
- Wide transformations such as groupBy() and orderBy() involve shuffling and are more expensive than narrow transformations.
- Spark executes transformations only when an action is called due to Lazy Evaluation.

---