http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions016.htm

SELECT CAST('22-OCT-1997' AS TIMESTAMP WITH LOCAL TIME ZONE) 
   FROM dual;

SELECT product_id, 
   CAST(ad_sourcetext AS VARCHAR2(30))
   FROM print_media;

CREATE TYPE address_book_t AS TABLE OF cust_address_typ;
/
CREATE TYPE address_array_t AS VARRAY(3) OF cust_address_typ;
/
CREATE TABLE cust_address (
   custno            NUMBER, 
   street_address    VARCHAR2(40), 
   postal_code       VARCHAR2(10), 
   city              VARCHAR2(30),
   state_province    VARCHAR2(10), 
   country_id        CHAR(2));

CREATE TABLE cust_short (custno NUMBER, name VARCHAR2(31));

CREATE TABLE states (state_id NUMBER, addresses address_array_t);

SELECT CAST(s.addresses AS address_book_t)
   FROM states s 
   WHERE s.state_id = 111; 
