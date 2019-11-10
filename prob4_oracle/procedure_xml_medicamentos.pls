create or replace PROCEDURE XML_MED IS

xmldata XMLTYPE;

BEGIN
    SELECT XMLELEMENT("medicamentos",
           XMLAGG(
             XMLELEMENT("medicamento",
               XMLFOREST(
                 m.codigo,
                 m.nombrecomercial,
                 m.laboratorio,
                 m.financiadoss,
                 m.necesitareceta
               )
             )
           ) 
         )
    INTO xmldata
    FROM medicamentos m;
    
    INSERT INTO xml_tab VALUES (1, xmldata);
    COMMIT;
    
END XML_MED;
/
