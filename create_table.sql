/* script to create tables to import data from csv
	1. card_holder
	2. credit_card
	3. transaction
	4. merchant
	5. merchant_category
*/

CREATE TABLE
	card_holder
	( 
	  id integer PRIMARY KEY NOT NULL,
	  name varchar(50)
	);

CREATE TABLE
	credit_card
	( 
	  card varchar(20),
	  cardholder_id integer NOT NULL,
 	  FOREIGN KEY (cardholder_id) REFERENCES card_holder(id)
	);
	
CREATE TABLE
	merchant_category
	(
		id integer PRIMARY KEY NOT NULL,
		name varchar(50)
	);
	
CREATE TABLE
	merchant
	(
		id integer PRIMARY KEY NOT NULL,
		name varchar(50),
		id_merchant_category integer NOT NULL,
		FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
	);

CREATE TABLE
	transaction
	(
		id integer PRIMARY KEY NOT NULL,
		date timestamp,
		amount float,
		card varchar(20) NOT NULL,
		id_merchant integer NOT NULL,
		FOREIGN KEY (id_merchant) REFERENCES merchant(id)
	);
