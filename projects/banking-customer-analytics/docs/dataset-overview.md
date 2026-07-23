# Dataset Overview

## Dataset Information

| Item | Details |
|------|---------|
| Dataset Name | Bank Customer Behavior and Churn Dataset |
| Source | Kaggle |
| Domain | Retail Banking |
| File Format | CSV |
| Number of Records | 80,000 |
| Number of Features | 26 |
| Target Variable | `exit` |

---

# Project Objective

The objective of this project is to analyse customer behaviour and identify factors associated with customer churn in a retail banking environment.

The findings will be used to support business decision-making and improve customer retention.

---

# Initial Assessment

### Strengths

- Large dataset with 80,000 customer records.
- Contains demographic, financial and behavioural information.
- Includes a clearly defined target variable (`exit`).
- Suitable for SQL, Python and Power BI analysis.
- No missing values detected during the initial review.

### Limitations

- Personal identifiers such as `full_name` and `address` are not useful for analysis.
- Dataset represents a snapshot rather than complete transaction history.
- Risk-related variables may require careful interpretation because they appear to be derived metrics.

---

# Expected Business Questions

This dataset can help answer questions such as:

- Which customer groups are more likely to churn?
- Does customer engagement affect churn?
- How do balance and credit score relate to customer retention?
- Which customer segments should the bank prioritise?
- Which characteristics are common among loyal customers?

---

# Next Steps

The next phase of the project is Data Profiling.

This includes:

- Reviewing every feature
- Classifying variables
- Checking data types
- Understanding business meaning
- Identifying variables for analysis