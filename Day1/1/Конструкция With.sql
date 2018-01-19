with
   case_of as (
   select distinct department_id
   from departments
   where location_id = 1800),
   
   case_of_table as (
   select employee_id, last_name, case when department_id in (select case_of.department_id from case_of) then 'CANADA' else 'USA' end location_
   from employees)

select *
from case_of_table;
