# Fraud Detection

### Context
The Data Analytics team has reviewed 25 credit card holders historical transactions and consumptions pattern in order to indentify possible fraudulent transactions. Specifically, the review seeks to answer the following questions:
*  Is there evidence to suggest that a credit card has been hacked?
*  Has there been any fraudulent transaction made?
*  What are the top 5 merchants prone to being hacked using small transactions?

CFO has also requested a more detailed analysis on specific card holders. This README presents the observations and conclusion of the review and analysis. 

### Data and Model
To study the consumption pattern, we have relied on daily credit card transaction data for the period from 01 Jan 2018 to 31 December 2018. A database model was defined to store the credit card transaction data and a PostgreSQL database was created based on the model. The entity relationship diagram below sets out the defined database model.

![](./Diagram/ERD_Fraud_Detection.jpg)

Once the database schema is created, data was imported from the corresponding csv files. 

### Results and Obesrvations
#### Part 1. Potential Fraudelent Transactions
Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by most cardholders. The chart below shows the total number of transactions that are less than $2.00 per cardholder. <br>

![](./Diagram/plot_twoless.jpeg)

It is unreasonable to expect no small transactions. Small transactions could be genuine. To narrow down the list of potential fraudulent transactions, we analyse the consumption pattern by analysing the daily maximum transaction amount by cardholders. 

![](./Diagram/plot_maxtxn.jpeg)

Cardholders with small transactions and also had large transactions (greater than $1000) are likely to have their credit card being hacked. From the total 25 cardholders reviewed, we have identified 10 cardholders may have their credit cards hacked and warrant an in-depth investigation. They are cardholder 1, 3, 6, 7, 9, 12, 16, 18, 24 and 25.



#### Part 2. Specific Card Holders
**Card holder 2**

![](./Diagram/Plot_Cardholder_2.png)

**Card holder 18**
![](./Diagram/Plot_Cardholder_18.png)


**Card holder 25**


![](./Diagram/Boxplot_Cardholder_25.png)
