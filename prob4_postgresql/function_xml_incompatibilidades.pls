CREATE FUNCTION xml_incomp() RETURNS varchar AS $xml_incomp$ 
DECLARE
    var varchar;
BEGIN
    SELECT table_to_xml('incompatibilidades', true, false, '') INTO var;

    RETURN var;
END;
$xml_incomp$ LANGUAGE plpgsql;
