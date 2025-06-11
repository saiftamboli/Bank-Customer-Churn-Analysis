CREATE DATABASE Portfolio;
USE portfolio;
drop table bank_customer_churn;
RENAME TABLE `bank customer churn prediction` TO bank_customer_churn;

alter table bank_customer_churn
add column credit_score_category varchar(10);
SET SQL_SAFE_UPDATES = 0;
update bank_customer_churn
set credit_score_category = CASE
    WHEN credit_score >= 800 THEN 'Excellent'
    WHEN credit_score >= 740 THEN 'Very Good'
    WHEN credit_score >= 670 THEN 'Good'
    WHEN credit_score >= 580 THEN 'Fair'
    ELSE 'Poor'
  END ;
  
alter table bank_customer_churn
add column age_category varchar(20);
update bank_customer_churn
set age_category=CASE
    WHEN age < 18 THEN 'Minor'
    WHEN age >= 18 AND age < 30 THEN 'Young Adult'
    WHEN age >= 30 AND age < 50 THEN 'Middle-aged Adult'
    WHEN age >= 50 AND age < 65 THEN 'Mature Adult'
    ELSE 'Senior'
  END ;
  
select *from bank_customer_churn;
ALTER TABLE bank_customer_churn ADD churn_status VARCHAR(20);
ALTER TABLE bank_customer_churn ADD Active_status VARCHAR(20);
UPDATE bank_customer_churn
SET churn_status = CASE
    WHEN churn = 1 THEN 'CHURN'
    WHEN churn = 0 THEN 'NOT CHURN'
    ELSE NULL -- This line is optional, it handles any other values like NULL
END;

UPDATE bank_customer_churn
SET active_status = CASE
    WHEN active_member = 1 THEN 'active'
    WHEN active_member = 0 THEN 'inactive'
    ELSE NULL -- Handles any other values, like NULLs
END;