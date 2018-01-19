CREATE MATERIALIZED VIEW LOG 
    ON "EMPLOYEES" 
TABLESPACE "EXAMPLE" 
WITH ROWID, PRIMARY KEY ( DEPARTMENT_ID, SALARY) 
INCLUDING NEW VALUES


CREATE MATERIALIZED VIEW EMP_sum
 TABLESPACE example
 BUILD IMMEDIATE
 REFRESH FAST
 ENABLE QUERY REWRITE
 AS
select sum(t.salary),t.department_id,count(*), 
  from employees t
  GROUP BY t.department_id


grant create snapshot to HR;--CREATE MATERIALIZED VIEW 


select /*+REWRITE*/ sum(t.salary),t.department_id 
  from employees t
  GROUP BY t.department_id

--!!
CREATE MATERIALIZED VIEW EMP_sum
 TABLESPACE example
 BUILD IMMEDIATE
 REFRESH FAST
 ENABLE QUERY REWRITE
 AS
select sum(t.salary)
  ,t.department_id
  ,count(t.salary) 
  ,count(*) 
  from employees t
  GROUP BY t.department_id

-- COOL!
CREATE MATERIALIZED VIEW "EMP_SUM" 
TABLESPACE "EXAMPLE" 
BUILD IMMEDIATE  
USING INDEX TABLESPACE "INDX" 
REFRESH FAST 
ON COMMIT  
ENABLE QUERY REWRITE 
AS
select sum(t.salary)
  ,t.department_id
  ,count(t.salary) 
  ,count(*) 
  from employees t
  GROUP BY t.department_id

BEGIN
   DBMS_STATS.GATHER_TABLE_STATS(
     ownname => 'HR',
     tabname => 'EMP_SUM');
END;

!--------------------
select 
  d.department_name
  ,sum(e.salary)
  from employees e JOIN departments d
    ON e.department_id=d.department_id
  GROUP BY d.department_name

 create index emp_sum_idx on EMP_SUM (department_id);