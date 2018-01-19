create materialized view cust_sales_mv
  BUILD IMMEDIATE
   REFRESH FAST ON COMMIT
   ENABLE QUERY REWRITE as
select 
  c.cust_id
  ,SUM(amount_sold) AS dollar_sales
  ,COUNT(amount_sold) AS cnt_dollars
  ,COUNT(*) AS cnt
from sales s, customers c
where s.cust_id=c.cust_id
 group by c.cust_id ;
 
 drop  materialized view cust_sales_mv;
 
 drop  MATERIALIZED VIEW LOG ON customers;
drop MATERIALIZED VIEW LOG ON sales ;

CREATE MATERIALIZED VIEW LOG ON sh.sales 
   WITH  SEQUENCE,ROWID(amount_sold,cust_id)
   INCLUDING  NEW VALUES; 

CREATE MATERIALIZED VIEW LOG ON sh.customers 
   WITH  SEQUENCE,ROWID(cust_id)
   INCLUDING  NEW VALUES;    
