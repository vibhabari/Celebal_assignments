# Brief Summary – Azure Cloud Fundamentals and Data Pipeline Implementation using ADF

**Objective:**

Understand Azure cloud concepts and build an end-to-end data pipeline using Storage Account and Azure Data Factory

**Implementation:**

* Created a Resource Group to organize and manage all Azure resources used in the project.
* Created a Storage Account and configured a Blob Container for storing data files.
* Uploaded a CSV file to Azure Blob Storage to serve as the source dataset.
* Created an Azure Data Factory instance and explored its Author, Monitor, and Manage modules.
* Configured a Linked Service to establish connectivity between Azure Data Factory and Azure Blob Storage.
* Created source and destination datasets to define the locations for data extraction and loading.
* Implemented a Get Metadata activity to validate file availability and retrieve information such as file size, existence, and last modified date.
* Built a data pipeline using the Copy Data activity to transfer data from the source location to the destination folder.
* Assigned appropriate IAM roles such as Reader and Contributor to ensure secure access between Azure services.
* Executed the pipeline using the Debug/Trigger option and monitored its execution through the Monitor tab.
* Verified pipeline execution status and activity run details to ensure successful completion of the workflow.
* Validated the output by confirming that the copied file was available in the destination location within Blob Storage.

**Result:**

* Successfully established connectivity between Azure Storage and Azure Data Factory.
* The Copy Data activity successfully moved the CSV file from the source Blob container to the destination folder.
* Pipeline execution completed successfully without errors and was monitored through Azure Data Factory.

