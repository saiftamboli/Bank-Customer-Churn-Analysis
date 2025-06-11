# BANK CUSTOMER CHURN ANALYSIS USING SQL & Power BI
Explore the live Power BI dashboard for interactive visualisations: [Link](https://app.powerbi.com/view?r=eyJrIjoiZTIzZWYxNjQtNjAzMy00YWFiLWE5NzQtYzlmZjIyYWQwZTMyIiwidCI6ImUwYzk0NGU4LWM5N2YtNGUwMS04MWUwLWRkMzZjZTk5YTgwYyJ9)
## What is Bank Churn?
Bank customer churn, also known as customer attrition, refers to the phenomenon where customers stop doing business with a bank or switch to another bank. Churn is a critical metric for banks as it directly impacts their customer base and revenue. Customer churn can occur due to various reasons, such as dissatisfaction with services, better offers from competitors, changes in financial needs, or poor customer experiences.
Understanding and predicting bank customer churn is crucial for banks to proactively manage customer relationships, improve customer satisfaction, and reduce revenue loss. By identifying customers who are at a higher risk of churning, banks can implement targeted retention strategies, personalised marketing campaigns, and tailored customer service to mitigate churn and enhance customer loyalty.
![Customer-Churn](https://github.com/user-attachments/assets/26ad7f09-34fd-4f25-9e59-81c67ff15a47)

## ABOUT DATA:-
In this dataset, we have 12 columns with 10000 records.
This dataset has the following columns :  
customer_id, credit_score, country, gender, age, tenure, balance, products_number, credit_card, active_member, estimated_salary, churn

## AIM:-
The aim of the data will be to predict Customer Churn.

## ANALYSIS:-

```sql
create database portfolio;
use portfolio;

create table bank_customer_churn 
( customer_id int,
  credit_score int,
  country varchar(15),
  gender varchar(8),
  age int,
  tenure int,
  balance float,
  products_number int,
  credit_card int,
  active_member int,
  estimated_salary float,
  churn int);
```
## A] Overview of the dataset:
```sql
select count(*) as Total_records from bank_customer_churn;
```
![image](https://github.com/user-attachments/assets/ae997be4-3b1a-4338-b9a2-94a8d624e864)
### Que] Are there any missing values in the dataset?
```sql
 select count(distinct customer_id) AS TOTAL_UNIQUE_RECORDS
 from bank_customer_churn;
 ```
![image](https://github.com/user-attachments/assets/5de72111-158c-47ca-aa70-6b0adef781fe)
NO, THERE ARE NO MISSING ITEMS

In this case, you're aiming to enrich the bank_customer_churn table by incorporating a new column named credit_score_category.  
This code snippet enhances the data by adding a new dimension (credit score category). This WILL be beneficial for further analysis and data visualisation tasks.

```sql
alter table bank_customer_churn
add column credit_score_category varchar(10);

update bank_customer_churn
set credit_score_category = CASE
    WHEN credit_score >= 800 THEN 'Excellent'
    WHEN credit_score >= 740 THEN 'Very Good'
    WHEN credit_score >= 670 THEN 'Good'
    WHEN credit_score >= 580 THEN 'Fair'
    ELSE 'Poor'
  END ;

  -- Modify the data type of the age_category column in the bank_customer_churn table to varchar(20). This allows for
     storing more descriptive category labels.
  -- Update the age_category values by categorising customers based on their age ranges using a CASE statement. This enhances
     data organisation and facilitates further analysis.
  
alter table bank_customer_churn
modify age_category varchar(20);

update bank_customer_churn
set age_category=CASE
    WHEN age < 18 THEN 'Minor'
    WHEN age >= 18 AND age < 30 THEN 'Young Adult'
    WHEN age >= 30 AND age < 50 THEN 'Middle-aged Adult'
    WHEN age >= 50 AND age < 65 THEN 'Mature Adult'
    ELSE 'Senior'
  END ; 
  ```

## B] Exploratory Data Analysis (EDA):

### Que] What is the distribution of the target variable (churn)?
```sql
select churn,count(churn) as total_count ,
concat(round(COUNT(churn) * 100.0 / SUM(COUNT(churn)) OVER (),2),'%') AS churn_percentage
 FROM bank_customer_churn 
group by churn;
```
![image](https://github.com/user-attachments/assets/d4f7fb4a-fbf6-4157-ab3f-13d70faf1463)
### Que] How do the input variables (credit score, age, balance, etc.) vary with respect to churn?
```sql
select credit_score_category,count(case when churn=1 then 1 end ) as total_churn_customer
from bank_customer_churn
group by credit_score_category
order by total_churn_customer desc;
```
![image](https://github.com/user-attachments/assets/407c4658-b5be-4885-8529-7c5e29a52da0)

```sql
select age_category,count(case when churn=1 then 1 end ) as total_customer_churn
from bank_customer_churn
group by age_category
order by total_customer_churn desc;
```
![image](https://github.com/user-attachments/assets/7e4dbd6a-fb39-4d32-af14-fdc2f7f6fcfa)

```sql
select age_category,count(case when churn=1 then 1 end ) as total_customer_churn
from bank_customer_churn
group by age_category
order by tot_customer_churn desc;
```
![image](https://github.com/user-attachments/assets/9ff282d0-67ea-4d25-952b-50e8eb841978)

```sql
select country,count(case when churn=1 then 1 end ) as total_churn_customer
from bank_customer_churn
group by country
order by total_churn_customer desc;
```
![image](https://github.com/user-attachments/assets/fd6201be-8364-4304-809a-bdeddcb213f2)

### Que] Are there any correlations between the input variables and churn?
- Approximately 81% of churn is contributed by customers categorised under the credit score categories of 'Poor', 'Fair', and 'Good'.
- Among the total of 2037 churned customers, Middle-aged Adults accounted for 1279 (approximately 62.82%), while Mature Adults contributed 591 (approximately 29.01%) to the churn rate.
- Out of the 2037 churned customers, approximately 55.93% were Female, and approximately 44.07% were Male.
- Out of the 2037 churned customers, approximately 39.98% were from Germany, 39.75% were from France, and 20.27% were from Spain.

## C] Customer demographics analysis:
### Que] What is the distribution of customers by country?
```sql
select country,count(*) as TOTAL_CUSTOMER
from bank_customer_churn
group by country
ORDER BY TOTAL_CUSTOMER DESC;
```
![image](https://github.com/user-attachments/assets/4988c0ab-4bfa-48e7-8dd7-ad2f1f21a45b)

### Que] How does churn vary across different demographic groups?
```sql
select country,count(case when churn=1 then 1 end ) as total_churn_customer
from bank_customer_churn
group by country
order by total_churn_customer desc;
```
![image](https://github.com/user-attachments/assets/2ece9185-dbf6-411c-b2c5-36040b333a60)

- INSIGHT  
  1. France has the highest number of total customers.
  2. Germany has the highest number of churned customers, followed    closely by France and then Spain.
  3. Despite having a lower total number of customers compared to France, Germany has a higher number of churned customers, indicating a potentially higher churn rate.
## D] Product and service analysis:

### What is the distribution of customers by the number of products they have?
```sql
select products_number,count(*) as total_customer
from bank_customer_churn
group by products_number
order by total_customer desc;
```
![image](https://github.com/user-attachments/assets/5d290a3d-b7ab-4054-aa17-bac170b82820)

### How does churn vary based on the number of products a customer has?
```sql
select products_number,total_churn_customer,total_customer,
concat(round((total_churn_customer / total_customer) * 100,1),' %') as churn_rate from
(select products_number,count(case when churn=1 then 1 end ) as total_churn_customer,count(*) as total_customer
from bank_customer_churn
group by products_number
order by total_churn_customer desc) as x;
```
![image](https://github.com/user-attachments/assets/0e87facb-3391-4799-a043-f241e680f674)

- INSIGHT  
  High churn rate was observed in product categories 3 and 4. This could  involve factors like product pricing, competition, customer service quality, or lack of features.

## E] Customer behaviour analysis:
### Que] How does tenure (length of time as a customer) vary with churn?
```sql
SELECT tenure,count(case when churn=1 then 1 end ) as tot_churn_customer
from bank_customer_churn
group by tenure
order by tot_churn_customer desc;
```
### Que] Do active members have lower churn rates compared to inactive members?
```sql
select active_member,CONCAT(round(total_churn_customer/total,2) * 100,'%') as churn_rates from(
SELECT active_member,count(case when churn=1  then 1 end ) as total_churn_customer,
count(*) total
from bank_customer_churn
group by active_member
order by active_member desc) x;
```
![image](https://github.com/user-attachments/assets/05c56133-0534-486c-b804-811046b6916d)

- INSIGHTS
  1. Customers who are not active members (active_member = 0) have a higher churn rate at approximately 27.00%. Customers who are active members (active_member = 1) have a lower churn rate at approximately 14.00%.
  2. Being an active member appears to be associated with a lower churn rate compared to inactive membership. This suggests that active engagement with the bank's services may contribute to higher customer retention rates.
### Are there any specific customer segments that are more prone to churn, and how can the bank address their needs?
   
```sql
     WITH churn_data AS (
  SELECT credit_score_category,
         COUNT(CASE WHEN churn = 0 and active_member=0 THEN 1 END) AS total
  FROM bank_customer_churn
  GROUP BY credit_score_category
)
SELECT
  credit_score_category,total,
  round(total * 100.0 / SUM(total) OVER (),2) AS per
FROM churn_data
ORDER BY total DESC;
```
![image](https://github.com/user-attachments/assets/059e91f8-d97e-4101-b60d-fcfe399dc8f9)

- INSIGHT
  1. The distribution of churned customers by credit score category indicates that a significant proportion of churned customers fall into the 'Fair', 'Poor', and 'Good' credit score categories.
  2. Customers with lower credit scores ('Fair' and 'Poor') contribute to a larger portion of churn compared to those with higher credit scores ('Very Good' and 'Excellent').
# PREDICTION
- Out of the total 7963 customers, approximately 31% of them, who are categorised under the 'Fair', 'Poor', and 'Good' credit score categories and are currently inactive, are at risk of churning.
# RECOMMENDATIONS
- Focus on Customer Engagement: Encourage inactive members to become more engaged with the bank's services by offering personalised incentives, targeted promotions, and improved customer support. Actively communicate with customers to understand their needs and preferences better.

- Improve Product Offerings: Investigate the reasons behind the high churn rates observed in product categories 3 and 4. Conduct market research to understand customer expectations, competitors' offerings, and areas for improvement. Consider adjusting product pricing, enhancing customer service quality, or introducing new features to increase customer satisfaction and retention.

- Targeted Marketing and Retention Strategies: Develop targeted marketing campaigns and retention strategies tailored to different customer segments based on factors such as credit score categories, age groups, and gender. Offer customised products, services, and incentives to address the specific needs and preferences of each segment.

- Enhance Customer Service Quality: Invest in training and development programs to improve the quality of customer service provided by bank staff. Implement systems for collecting and analysing customer feedback to identify areas for improvement and ensure the timely resolution of customer issues.

- Monitor and Address Churn Contributors: Continuously monitor key factors contributing to churn, such as credit score categories, age groups, and gender. Implement proactive measures to address these contributors, such as targeted interventions, loyalty programs, and product enhancements. Conduct focus groups or surveys with customers from 'Fair', 'Poor', and 'Good' credit score segments to understand their pain points and unmet needs.

- Expand Market Reach: While France currently has the highest number of total customers, consider strategies to expand market reach in other regions, such as Germany and Spain. Develop localised marketing campaigns and product offerings to attract and retain customers in these regions.

If you find this resource helpful, please give it a star ⭐️ and share it with others!
