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
		EXTRACT(MIN FROM date) AS txn_min,
		t2.cardholder_id,
		t1.amount,
		t3.name AS merchant_name,
		t4.name AS merchant_category,
		CASE 
		 	WHEN (amount < 2)  THEN 1 
			WHEN (amount >= 2) 	THEN 0
		 END AS twoless_ind,
		 CASE
		    WHEN(amount > 500) THEN 1
			WHEN(amount <=500) THEN 0
		 END AS large_ind
 FROM 	transaction t1, 
 		credit_card t2, 
		merchant t3, 
		merchant_category t4
 WHERE 	t1.card = t2.card
 AND 	t1.id_merchant = t3.id
 AND 	t3.id_merchant_category = t4.id
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
CREATE VIEW v_top_100_txn_7to9am AS
SELECT		txn_id,
			date,
			txn_hour,
			txn_min,
			amount,
			merchant_name,
			merchant_category
FROM 	(	
			( --pick up transactions made from 7am to 8am
				SELECT		txn_id,
							date,
							txn_min,
							txn_hour,
							amount,
							merchant_name,
							merchant_category
				FROM		V_data_joined
				WHERE		txn_hour IN (7,8)
			)
			UNION ALL
			( --pick up transaction made at 9am
				SELECT		txn_id,
							date,
							txn_min,
							txn_hour,
							amount,
							merchant_name,
							merchant_category
				FROM		V_data_joined
				WHERE		txn_hour = 9
				AND			txn_min = 0
			)
		 ) f
 ORDER BY 	amount DESC
 LIMIT 100
 ;


--top 5 merchants prone to being hacked
CREATE VIEW v_top5_merchant AS
SELECT 	merchant_name,
		merchant_category,
		small_txn_cnt,
		large_txn_cnt
FROM 	(SELECT  merchant_name,
				 merchant_category,
				 sum(twoless_ind) AS small_txn_cnt,
				 sum(large_ind) AS large_txn_cnt
		FROM 	v_data_joined
		GROUP BY merchant_name, merchant_category
		)f
ORDER BY small_txn_cnt DESC, large_txn_cnt DESC
LIMIT 5
;

