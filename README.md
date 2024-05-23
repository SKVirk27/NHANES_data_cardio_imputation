NHANES Data Analysis
This project focuses on the analysis and imputation of NHANES (National Health and Nutrition Examination Survey) data from various cycles. The data includes demographic, dietary, medication, questionnaire, examination, environmental factors, smoking, physical activity, body measurements, blood lipid, blood glucose, and alcohol consumption datasets.

Overview
The goal of this project is to clean, combine, and analyze multiple NHANES datasets across different years. The final dataset is then imputed to handle missing values, ensuring a robust dataset for further analysis.

Project Structure
Data Loading and Cleaning: Load datasets from different NHANES cycles, combine them, and select relevant attributes.
Imputation: Use the mice package for multiple imputation to handle missing data.
Analysis: Perform data analysis, including NA value counts and exporting the final imputed dataset.
Required Libraries
This project utilizes the following R libraries:

RNHANES
sqldf
plyr
dplyr
haven
mice
ggplot2
