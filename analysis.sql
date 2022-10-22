
--count the transactions that are less than $2.00 per cardholder
CREATE VIEW  small_transaction AS
SELECT  cardholder_id,
		count(cardholder_id) as small_trans_cnt
FROM 	(	--select all transaction amount less than $2.00
		 	SELECT 	t1.id,
					t1.date,
					t1.amount,
					t2.cardholder_id
			FROM 	transaction t1, credit_card t2
			WHERE 	t1.card = t2.card
			AND 	amount < 2
	 	 )f
GROUP BY cardholder_id
ORDER BY small_trans_cnt DESC
;


