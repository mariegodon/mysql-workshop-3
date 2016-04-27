CREATE TABLE Account (id INT AUTO_INCREMENT PRIMARY KEY, email VARCHAR(255), password VARCHAR(40), createdOn DATETIME, modifiedOn DATETIME);

CREATE TABLE AddressBook (id INT AUTO_INCREMENT PRIMARY KEY, accountId INT, name VARCHAR(255), createdOn DATETIME, modifiedOn DATETIME);

ALTER TABLE AddressBook ADD FOREIGN KEY (accountId) REFERENCES Account(id) ON DELETE SET NULL;

CREATE TABLE Entry (id INT AUTO_INCREMENT PRIMARY KEY, addressBookId INT, firstName VARCHAR(255), lastName VARCHAR(255), birthday DATETIME, type ENUM("phone", "address","electronic-mail"));

ALTER TABLE Entry ADD FOREIGN KEY (addressBookId) REFERENCES AddressBook(id);

SELECT CONCAT(UPPER(SUBSTRING(e.firstName, 1, 1)), SUBSTRING(e.firstName, 2, LENGTH(e.firstName)-2), UPPER(SUBSTRING(e.firstName, LENGTH(e.firstName)))) AS firstName FROM AddressBook ab JOIN Entry e ON e.AddressBookId = ab.id WHERE ab.name = "Pharetra Ut Limited";

SELECT em.type, em.content AS email, e.addressBookId FROM ElectronicMail em JOIN Entry e ON em.entryId = e.id WHERE e.addressBookId = 100;

SELECT p.type, p.subtype, p.content AS phoneNumber, CONCAT(e.lastName, ", ", e.firstName) AS person FROM Phone p JOIN Entry e ON p.entryId = e.id WHERE e.firstName = "Charlotte" AND e.lastName = "Jenkins";

SELECT SUBSTRING_INDEX(em.content, "@", -1) AS domainNames FROM ElectronicMail em GROUP BY SUBSTRING_INDEX(em.content, "@", -1);

SELECT COUNT(*) AS totalDomainNames FROM (SELECT SUBSTRING_INDEX(em.content, "@", -1) AS blah1 FROM ElectronicMail em GROUP BY SUBSTRING_INDEX(em.content, "@", -1)) AS T;

SELECT p.subtype AS type, COUNT(*) AS total FROM Phone p JOIN Entry e ON p.entryId = e.id WHERE e.birthday > "1950-10-01" AND e.birthday < "1960-10-01" GROUP BY p.subtype;

(SELECT e.addressBookId FROM Phone p JOIN Entry e ON p.entryId = e.id WHERE p.content LIKE "_-%" GROUP BY e.addressBookId);

SELECT em.type, em.content, r.addressBookId, e.addressBookId FROM ElectronicMail em JOIN Entry e ON em.entryId = e.id JOIN (SELECT e.addressBookId FROM Phone p JOIN Entry e ON p.entryId = e.id WHERE p.content LIKE "_-%" GROUP BY e.addressBookId) AS r ON r.addressBookId = e.addressBookid;

SELECT CONCAT(lastName, ", ", firstName) FROM Entry WHERE birthday >= "%20:00:00" AND birthday <= "%21:00:00" AND birthday NOT LIKE "%-02-%";

SELECT CONCAT(lastName, ", ", firstName) AS name, birthday FROM Entry WHERE DATE_FORMAT(birthday, "%H") >= 20 AND DATE_FORMAT(birthday, "%H") < 21 AND DATE_FORMAT(birthday, "%m") != 2 ORDER BY birthday ASC;

SELECT city, country FROM Address WHERE country = "Canada" OR country = "Austria" OR country = "Isle Of Man" OR country = "Ireland" OR country = "Japan" ORDER BY country;

SELECT SUBSTRING(content, 1, 1) AS countryCode, SUBSTRING(content, 3, 3) AS areaCode, SUBSTRING(content, 7,8) AS landLine FROM Phone WHERE content LIKE "_-%" LIMIT 100;

SELECT DATEDIFF(modifiedOn, createdOn) AS timeFromCreatedToModified FROM AddressBook;

SELECT CASE LENGTH(rev)
    WHEN 10 THEN CONCAT("(", LEFT(rev,3), ")", SUBSTRING(rev, 5, 3), RIGHT(rev, 4))
    WHEN 11 THEN CONCAT(LEFT(rev, 1), "-", SUBSTRING(rev, 2, 3), "-", SUBSTRING(rev, 5, 3), "-", RIGHT(rev, 4))
    END
    AS reversedFaxNumber,
    rev,
    content
    FROM
    (SELECT 
        CASE content 
            WHEN LEFT(content, 1)="(" THEN REVERSE(REPLACE(REPLACE(REPLACE(REPLACE(content, "(", ""), ")", ""), "-", ""), " ", ""));
            WHEN LEFT(content, 1)="1" THEN REVERSE(CONCAT(LEFT(content, 1), SUBSTRING(content,3,3), SUBSTRING(content, 7,3), SUBSTRING(content, 11,4)))
        END 
        AS rev,
        subtype,
        content
        FROM Phone) AS r
    WHERE subtype = "fax" LIMIT 6;
    



FROM Phone WHERE subtype = "fax" AND content LIKE "_-%";

(SUBSTRING(REPLACE(content, ' ', ''), 2, 3), 





