update SALES t set t.amount_sold=t.amount_sold+1 where t.cust_id='8540' ;
commit;
select 8450,sum(v.amount_sold) from SALES v where v.cust_id='8540' 
union all
select t.cust_id,t.dollar_sales from CUST_SALES_MV t where t.cust_id=8540;
