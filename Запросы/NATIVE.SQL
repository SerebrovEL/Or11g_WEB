-- "Native Compilation without a Third-Party C Compiler"
--http://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:1633099400346661781a 

create or replace
  function factorial_interpreted( p_n in number ) return number
  is
  begin
          if ( p_n = 1 )
          then
                  return 1;
          else
                  return factorial_interpreted( p_n-1 ) * p_n;
          end if;
  end;
/
alter session set plsql_compiler_flags = 'NATIVE';


alter session set PLSQL_Code_Type = 'NATIVE';


create or replace
  function factorial_native( p_n in number ) return number
  is
  begin
          if ( p_n = 1 )
          then
                  return 1;
          else
                  return factorial_native( p_n-1 ) * p_n;
          end if;
  end;
/


alter session set plsql_compiler_flags = 'INTERPRETED';


alter session set PLSQL_Code_Type = 'INTERPRETED';

 declare
          l_start number;
          l_n     number;
          l_e1    number;
          l_e2    number;
  begin
          l_start := dbms_utility.get_cpu_time;
          for i in 1 .. 20000
          loop
                  l_n := factorial_interpreted( 50 );
          end loop;
          l_e1 := dbms_utility.get_cpu_time-l_start;
          dbms_output.put_line( l_e1 || ' hsecs...' || l_n );

          l_start := dbms_utility.get_cpu_time;
          for i in 1 .. 20000
          loop
                  l_n := factorial_native( 50 );
          end loop;
          l_e2 := dbms_utility.get_cpu_time-l_start;
          dbms_output.put_line( l_e2 || ' hsecs...' || l_n );

          dbms_output.put_line( l_e2 || ' is ' || round(l_e2/l_e1*100,0) || '% of ' || 
l_e1 );
  end;
/