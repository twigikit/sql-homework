# Fraud Detection

### Context
The Data Analytics team has reviewed 25 credit card holders historical transactions and consumptions pattern in order to indentify possible fraudulent transactions. Specifically, the review seeks to answer the following questions:
*  Is there evidence to suggest that a credit card has been hacked?
*  Has there been any fraudulent transaction made?
*  What are the top 5 merchants prone to being hacked using small transactions?

CFO has also requested a more detailed analysis on specific card holders. This README presents the observations and conclusion of the review and the analysis. 

### Data and Model
To study the consumption pattern, we have relied on daily credit card transaction data for the period from 01 Jan 2018 to 31 December 2018. A database model was defined to store the credit card transaction data and a PostgreSQL database was created based on the model. The entity relationship diagram below sets out the defined database model.

![](./Diagram/ERD_Fraud_Detection.jpg)

### Analysis Results
#### Part 1. Potential Fraudelent Transactions


#### Part 2. Specific Card Holders
**Card holder 2**

![](./Diagram/Plot_Cardholder_2.png)

**Card holder 18**
![](./Diagram/Plot_Cardholder_18.png)


**Card holder 25**


![](./Diagram/Boxplot_Cardholder_25.png)
