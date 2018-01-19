http://www.oracle-base.com/articles/10g/utl_dbws-10g.php

CREATE OR REPLACE FUNCTION add_numbers (p_int_1 IN NUMBER,
                                        p_int_2 IN NUMBER)
  RETURN NUMBER
AS
  l_service          UTL_DBWS.service;
  l_call             UTL_DBWS.call;
  
  l_wsdl_url         VARCHAR2(32767);
  l_namespace        VARCHAR2(32767);
  l_service_qname    UTL_DBWS.qname;
  l_port_qname       UTL_DBWS.qname;
  l_operation_qname  UTL_DBWS.qname;

  l_xmltype_in       SYS.XMLTYPE;
  l_xmltype_out      SYS.XMLTYPE;
  l_return           NUMBER;
BEGIN
  l_wsdl_url        := 'http://www.oracle-base.com/webservices/server.php?wsdl';
  l_namespace       := 'http://www.oracle-base.com/webservices/';

  l_service_qname   := UTL_DBWS.to_qname(l_namespace, 'Calculator');
  l_port_qname      := UTL_DBWS.to_qname(l_namespace, 'CalculatorPort');
  l_operation_qname := UTL_DBWS.to_qname(l_namespace, 'ws_add');

  l_service := UTL_DBWS.create_service (
    wsdl_document_location => URIFACTORY.getURI(l_wsdl_url),
    service_name           => l_service_qname);

  l_call := UTL_DBWS.create_call (
    service_handle => l_service,
    port_name      => l_port_qname,
    operation_name => l_operation_qname);

  l_xmltype_in := SYS.XMLTYPE('<?xml version="1.0" encoding="utf-8"?>
    <ws_add xmlns="' || l_namespace || '">
      <int1>' || p_int_1 || '</int1>
      <int2>' || p_int_2 || '</int2>
    </ws_add>');
  l_xmltype_out := UTL_DBWS.invoke(call_Handle => l_call,
                                   request     => l_xmltype_in);
  
  UTL_DBWS.release_call (call_handle => l_call);
  UTL_DBWS.release_service (service_handle => l_service);

  l_return := l_xmltype_out.extract('//return/text()').getNumberVal();
  RETURN l_return;
END;
/
The output below shows the function in action.

SELECT add_numbers(1, 5) FROM dual;

ADD_NUMBERS(1,5)
----------------
               6

SQL>

SELECT add_numbers(10, 15) FROM dual;

ADD_NUMBERS(10,15)
------------------
                25

SQL>