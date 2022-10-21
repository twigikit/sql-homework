
--count the transactions that are less than $2.00 per cardholder
CREATE VIEW  small_transaction AS
SELECT  f.name,
		count(name) as transaction_count
FROM 	(	--select all transaction amount less than $2.00
		 	SELECT 	t1.id,
					t1.date,
					t1.amount,
					t1.card,
					t3.name	
			FROM 	transaction t1, credit_card t2, card_holder t3
			WHERE 	t1.card = t2.card
			AND 	t2.cardholder_id = t3.id
			AND 	amount < 2
	 	 )f
GROUP BY f.name
ORDER BY transaction_count DESC
;

SELECT *
FROM transaction




