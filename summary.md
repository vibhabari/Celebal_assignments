
# Data Cleaning Summary
A combined csv of all dataset is used and basic data exploration and cleaning using Pandas is performed on it.

## Tasks Performed
1. Loaded CSV dataset into a Pandas DataFrame.
2. Explored the dataset using:
   - head()
   - tail()
   - shape
   - columns
   - dtypes
3. Identified and handled missing values.
4. Performed filtering and column selection.
5. Doplicate valus are checked.
6. Created a derived column:
   - discount_amount = initial_price - final_price.
   It is mentioned to make a derived column of total_amount=price*quantity but as the quantity column is not present in the dataset so i have created a derived column named as discount_amount.
7. Saved the cleaned dataset as a new CSV file. 

## Files Included
- cleaned_data.csv (cleaned dataset)
- pandas_data_cleaning.ipynb (Jupyter Notebook)
