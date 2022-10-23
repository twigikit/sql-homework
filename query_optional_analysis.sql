--check total number of fraudulent transaction for other time window
SELECT		txn_id,
			date,
			txn_hour,
			txn_min,
			amount,
			cardholder_id,
			merchant_name,
			merchant_category
FROM 	(	
			( --pick up transactions made from 7am to 8am
				SELECT		txn_id,
							date,
							txn_min,
							txn_hour,
							amount,
							cardholder_id,
							merchant_name,
							merchant_category
				FROM		V_data_joined
				WHERE		txn_hour IN (15,16)
			)
			UNION ALL
			( --pick up transaction made at 9am
				SELECT		txn_id,
							date,
							txn_min,
							txn_hour,
							amount,
							cardholder_id,
							merchant_name,
							merchant_category
				FROM		V_data_joined
				WHERE		txn_hour = 17
				AND			txn_min = 0
			)
		 ) f
 ORDER BY 	amount DESC
