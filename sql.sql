CREATE TABLE Account (id INT AUTO_INCREMENT PRIMARY KEY, email VARCHAR(255), password VARCHAR(40), createdOn DATETIME, modifiedOn DATETIME);

CREATE TABLE AddressBook (id INT AUTO_INCREMENT PRIMARY KEY, accountId INT, name VARCHAR(255), createdOn DATETIME, modifiedOn DATETIME);

ALTER TABLE AddressBook ADD FOREIGN KEY (accountId) REFERENCES Account(id) ON DELETE SET NULL;

CREATE TABLE Entry (id INT AUTO_INCREMENT PRIMARY KEY, addressBookId INT, firstName VARCHAR(255), lastName VARCHAR(255), birthday DATETIME, type ENUM("phone", "address","electronic-mail"));

ALTER TABLE Entry ADD FOREIGN KEY (addressBookId) REFERENCES AddressBook(id);

SELECT CONCAT(UPPER(SUBSTRING(e.firstName, 1, 1)), SUBSTRING(e.firstName, 2, LENGTH(e.firstName)-2), UPPER(SUBSTRING(e.firstName, LENGTH(e.firstName)))) AS first_Names_In_Pharetra FROM AddressBook ab JOIN Entry e ON e.AddressBookId = ab.id WHERE ab.name = "Pharetra Ut Limited";
