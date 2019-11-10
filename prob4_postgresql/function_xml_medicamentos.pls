CREATE FUNCTION xml_med() RETURNS varchar AS $xml_med$ 
DECLARE
    var varchar;
BEGIN
    SELECT table_to_xml('medicamentos', true, false, '') INTO var;

    RETURN var;
END;
$xml_med$ LANGUAGE plpgsql;
