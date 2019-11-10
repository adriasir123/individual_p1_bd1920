create or replace PROCEDURE XML_INCOMP IS

xmldata XMLTYPE;

BEGIN
    SELECT XMLELEMENT("incompatibilidades",
           XMLAGG(
             XMLELEMENT("incompatibilidad",
               XMLFOREST(
                 i.codigomedicamento1,
                 i.codigomedicamento2
               )
             )
           ) 
         )
    INTO xmldata
    FROM incompatibilidades i;
    
    INSERT INTO xml_tab VALUES (2, xmldata);
    COMMIT;
    
END XML_INCOMP;
/
