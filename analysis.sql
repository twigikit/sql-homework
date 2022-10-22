/* Data preparation
Isolate (or group ) the transaction by each cardholder
 - join transaction and credit card tables where the card number is matching.
 - flag transaction that is less than $2.00 */
 
 CREATE VIEW v_data_joined AS
 SELECT t1.id AS txn_id,
		t1.date,
		EXTRACT(DAY FROM date) AS txn_day,
		EXTRACT(MONTH FROM date) AS txn_month,
		EXTRACT(HOUR FROM date) AS txn_hour,
		t2.cardholder_id,
		t1.amount,
		t3.name AS merchant_name,
		t4.name AS merchant_category,
		CASE 
		 	WHEN (amount < 2)  THEN 1 
			WHEN (amount >= 2) 	THEN 0
		 END AS twoless_ind
 FROM 	transaction t1, 
 		credit_card t2, 
		merchant t3, 
		merchant_category t4
 WHERE 	t1.card = t2.card
 AND 	t1.id_merchant = t3.id
 AND 	t3.id_merchant_category = t4.id
 ;

/* review the transaction by cardholder */
SELECT 		
			cardholder_id,
			EXTRACT(MONTH FROM date) AS txn_month,
			EXTRACT(DAY FROM date) AS txn_day,
			min(amount) AS min_amount,
			ROUND(CAST(max(amount) AS numeric),2) AS max_amount,
			ROUND(CAST(sum(amount) AS numeric),2) AS total_amount,
			ROUND(CAST(avg(amount) AS numeric),2) AS average_amount,
			sum(twoless_ind) AS num_txn_twoless,
			count(cardholder_id) AS num_txn_all
FROM 		data_all
GROUP BY	cardholder_id, txn_month, txn_day
ORDER BY 	cardholder_id, txn_month, txn_day
;

--count the transactions that are less than $2.00 per cardholder
CREATE VIEW v_txn_twoless AS 
SELECT 
			cardholder_id,
			sum(twoless_ind) AS num_txn_twoless
FROM		v_data_joined
GROUP BY	cardholder_id
ORDER BY 	cardholder_id
;

--top 100 highest transactions made between 7am and 9am
CREATE VIEW v_top_100_txn_am AS
SELECT		*
FROM		V_data_joined
WHERE		txn_hour IN (7,8,9)
ORDER BY 	amount DESC
LIMIT 100




