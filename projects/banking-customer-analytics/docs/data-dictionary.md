# Data Dictionary

## Purpose

This document describes each field in the banking customer churn dataset, including its expected data type, business meaning, analytical role, and any initial data-quality concerns.

| Column | Expected Type | Business Meaning | Analytical Role | Initial Notes |
|---|---|---|---|---|
| `id` | Integer | Unique customer identifier | Identifier | Expected to be unique; not used as a predictive feature |
| `full_name` | Text | Customer full name | Exclude | Personal identifier; not useful for analysis |
| `credit_sco` | Numeric | Customer credit score | Measure | Column name appears abbreviated and may need renaming |
| `gender` | Category | Customer gender | Dimension | Review unique values |
| `age` | Integer | Customer age | Measure / Dimension | Check minimum, maximum and unrealistic values |
| `occupation` | Category | Customer occupation | Dimension | Review category consistency |
| `balance` | Numeric | Customer account balance | Measure | Check range, zeros and outliers |
| `monthly_ir` | Numeric | Monthly income | Measure | Meaning should be verified; column name appears abbreviated |
| `address` | Text | Customer residential address | Exclude | Personal identifier and too granular for analysis |
| `origin_province` | Category | Customer province | Dimension | Review spelling and category consistency |
| `tenure_ye` | Integer | Length of banking relationship in years | Measure / Dimension | Column name should be renamed |
| `married` | Boolean / Category | Customer marital status | Dimension | Confirm values and interpretation |
| `nums_card` | Integer | Number of cards held | Measure | Check valid range |
| `nums_service` | Integer | Number of banking services used | Measure | Check valid range |
| `active_member` | Boolean | Whether the customer is active | Dimension | Potentially important churn indicator |
| `last_active_date` | Date | Most recent customer activity date | Date | Convert to date type |
| `last_transaction_month` | Numeric / Date-derived | Customer transaction recency indicator | Measure | Meaning and unit require verification |
| `created_date` | Date | Customer account creation date | Date | Convert to date type |
| `exit` | Boolean | Whether the customer churned | Target | Main outcome variable |
| `customer_segment` | Category | Assigned customer segment | Dimension | May be derived; interpretation required |
| `engagement_score` | Numeric | Customer engagement score | Measure | Derivation is unknown |
| `loyalty_level` | Category | Customer loyalty classification | Dimension | May be derived from other variables |
| `digital_behavior` | Category | Digital banking usage behaviour | Dimension | Review categories |
| `risk_score` | Numeric | Customer risk score | Measure | Derived metric; avoid assuming causality |
| `risk_segment` | Category | Customer risk classification | Dimension | Likely derived from `risk_score` |
| `cluster_group` | Category | Predefined customer cluster | Dimension | Likely produced by prior clustering |