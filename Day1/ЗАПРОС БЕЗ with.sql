select e.employee_id,
       e.last_name,
       (case
         when e.department_id = d.department_id then
          'Canada'
         else
          'USA'
       end) stran
  from hr.employees e, hr.departments d
 where d.department_id(+) = e.department_id
   and d.location_id(+) = 1800
