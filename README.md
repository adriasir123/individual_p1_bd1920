# TL;DR
En este repositorio se encuentra el código de mi parte individual para la práctica 1 de base de datos "Repaso de PL/SQL".
Además, la documentación de cada ejercicio con pruebas de funcionamiento, las podrás encontrar en este mismo README

---

## Problema 4 (oracle)
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




## Problema 7 (oracle)
(todo el código lo encontrarás en su directorio correspondiente)
