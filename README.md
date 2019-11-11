# TL;DR
En este repositorio se encuentra el código de mi parte individual para la práctica 1 de base de datos "Repaso de PL/SQL".
Además, la documentación de cada ejercicio con pruebas de funcionamiento, las podrás encontrar en este mismo README

---

## Problema 4 (Oracle)
(todo el código lo encontrarás en su directorio correspondiente)

Pasos para la transformación en xml de los datos de una tabla
### Paso 1
Crear una tabla donde se almacenarán los output xml de las tablas que queramos
```sql
CREATE TABLE xml_tab (
  id        NUMBER,
  xml_data  XMLTYPE
);
```
![Prueba tabla creada](https://i.imgur.com/cJv3H1j.png)  
*Prueba tabla creada*

### Paso 2
Creamos los 2 procedimientos que insertarán los datos xml de cada tabla (Medicamentos e incompatibilidades)
![Prueba creación procedimiento1](https://i.imgur.com/1BKCWE7.png)  
*Prueba creación procedimiento1*  
![Prueba creación procedimiento2](https://i.imgur.com/TzTlnmV.png)  
*Prueba creación procedimiento2*

Una vez creados los procedimientos, otra forma de comprobar que esto se hizo correctamente y que pertecen al usuario con el que los creamos, es listar los procedimientos de ese usuario específico con el siquiente bloque de código

```sql
SELECT owner, object_name
FROM ALL_OBJECTS
WHERE OBJECT_TYPE='PROCEDURE' AND OWNER='JUANDI';
```
![Prueba listado de procedimientos del usuario juandi](https://i.imgur.com/oNF2ej1.png)  
*Prueba listado de procedimientos del usuario juandi*

### Paso 3
Ejecutamos los 2 procedimientos para que finalmente, inserten esos datos. Lo hacemos con los siguientes bloques plsql
```plsql
BEGIN
    XML_MED;
END;
/
```
![Prueba ejecución correcta procedimiento1](https://i.imgur.com/XjdME6l.png)  
*Prueba ejecución correcta procedimiento1*

```plsql
BEGIN
    XML_INCOMP;
END;
/
```
![Prueba ejecución correcta procedimiento2](https://i.imgur.com/1OUkObW.png)  
*Prueba ejecución correcta procedimiento2*

### Paso 4
Mostramos los datos xml añadidos en xml_tab, para cada una de las tablas que hemos convertido en xml.  
**Datos XML Medicamentos**

```sql
SET LONG 500000000
SET PAGESIZE 50000

SELECT x.xml_data.getClobVal() xml_output
FROM   xml_tab x
WHERE x.id=1;
```
![Prueba mostrado de datos de medicamentos1](https://i.imgur.com/Le6pQ7s.png)  
![Prueba mostrado de datos de medicamentos2](https://i.imgur.com/WqlaPsT.png)
*Prueba mostrado de datos de medicamentos*

Podemos estar seguros de que estos datos son correctos, comparando esos datos con los que tiene la tabla real. Mostraré un select completo de esa tabla, para que se vea que todo está correcto:
![Select medicamentos](https://i.imgur.com/pZoYfhf.png)
*Datos de medicamentos*

**Datos XML Incompatibilidades**

```sql
SET LONG 500000000
SET PAGESIZE 50000

SELECT x.xml_data.getClobVal() xml_output
FROM   xml_tab x
WHERE x.id=2;
```
![Prueba mostrado de datos de Incompatibilidades1](https://i.imgur.com/peHNz1t.png)
![Prueba mostrado de datos de Incompatibilidades2](https://i.imgur.com/135vXD5.png)
*Prueba mostrado de datos de Incompatibilidades*

Podemos estar seguros de que estos datos son correctos, comparando esos datos con los que tiene la tabla real. Mostraré un select completo de esa tabla, para que se vea que todo está correcto:
![Select incompatibilidades](https://i.imgur.com/G6UlBHQ.png)  
*Datos de incompatibilidades*

> Fuentes: https://oracle-base.com/articles/misc/xmltable-convert-xml-data-into-rows-and-columns-using-sql


## Problema 4 (PostgreSQL)
(todo el código lo encontrarás en su directorio correspondiente)

Pasos para la transformación en xml de los datos de una tabla

### Paso 1
> En postgreSQL el proceso de transformar los datos de una tabla a xml se acorta ya que tenemos la suerte de contar con una función interna de postgreSQL llamada "table_to_xml()", que transforma toda una tabla a xml directamente para nosotros 

Lo primero que tendremos que hacer es crear una función por cada tabla que queramos transformar a xml, para tenerlo todo más organizado

**Creando función para medicamentos**
```plsql
CREATE FUNCTION xml_med() RETURNS varchar AS $xml_med$ 
DECLARE
    var varchar;
BEGIN
    SELECT table_to_xml('medicamentos', true, false, '') INTO var;

    RETURN var;
END;
$xml_med$ LANGUAGE plpgsql;
```
![](https://i.imgur.com/gupk0KC.png)  
*Prueba de creación de la función para la tabla medicamentos*

**Creando función para incompatibilidades**
```plsql
CREATE FUNCTION xml_incomp() RETURNS varchar AS $xml_incomp$ 
DECLARE
    var varchar;
BEGIN
    SELECT table_to_xml('incompatibilidades', true, false, '') INTO var;

    RETURN var;
END;
$xml_incomp$ LANGUAGE plpgsql;
```
![](https://i.imgur.com/HBL5kxA.png)  
*Prueba de creación de la función para la tabla incompatibilidades*

### Paso 2
Con la anterior comprobación de la creación de las funciones nos bastaría, pero vamos a ir un paso más allá, y vamos a listar exactamente las funciones que se han creado para el usuario juandi. Así sabremos al 100% que esas funciones se crearon, y que pertenecen al usuario juandi.

Vamos a tener que ejecutar el siguiente bloque de código para sacar esta información:
```sql
SELECT quote_ident(n.nspname) as schema , quote_ident(p.proname) as function 
FROM   pg_catalog.pg_proc p
JOIN   pg_catalog.pg_namespace n ON n.oid = p.pronamespace 
WHERE  n.nspname not like 'pg%' AND n.nspname = 'public';
```
![](https://i.imgur.com/IacWlwW.png)  
*Aquí vemos reflejado que juandi creó las 2 funciones que necesitamos*

### Paso 3
Después de tener las funciones creadas, ya sólo nos quedaría llamarlas, y ver el resultado.

**Llamada a la función de medicamentos**  
Lo hacemos de la siguiente manera:

```sql
select "xml_med"();
```
![](https://i.imgur.com/DMoV8WN.png)
![](https://i.imgur.com/SNX5Gzl.png)  
*Contenido XML de la tabla medicamentos*

**Llamada a la función de incompatibilidades**  
Lo hacemos de la siguiente manera:

```sql
select "xml_incomp"();
```
![](https://i.imgur.com/Yc3vfSr.png)
![](https://i.imgur.com/LPxoNve.png)  
*Contenido XML de la tabla incompatibilidades*

## Problema 7 (Oracle)
(todo el código lo encontrarás en su directorio correspondiente)

La idea general es que debe de saltar un trigger si introducimos un registro duplicado en la tabla Incompatibilidades.

### Paso 1
Mostraré los registros que tiene la tabla Incompatibilidades, para que veamos qué registro podríamos meter para que saltase el trigger
![](https://i.imgur.com/Ew63Onc.png)

Como vemos, existe AL8-0L5 pero no al revés. Por lo tanto, si insertamos 0L5-AL8, lo contrario, debería saltar el trigger de duplicidad.
Veámoslo en el paso 2.

### Paso 2
Insertaremos 0L5-AL8 para que salte el trigger que evita la duplicidad
![](https://i.imgur.com/5CKqEQj.png)  
*Trigger activado*

Efectivamente, ha saltado y funciona correctamente




