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
[Prueba tabla creada](https://www.google.com)
### Paso 2
Creamos los 2 procedimientos que insertarán los datos xml de cada tabla (Medicamentos e incompatibilidades)
[Prueba creación procedimiento1](https://www.google.com)
[Prueba creación procedimiento2](https://www.google.com)
Una vez creados los procedimientos, otra forma de comprobar que esto se hizo correctamente y que pertecen al usuario con el que los creamos, es listar los procedimientos de ese usuario específico con el siquiente bloque de código

```sql
SELECT owner, object_name
FROM ALL_OBJECTS
WHERE OBJECT_TYPE='PROCEDURE' AND OWNER='JUANDI';
```
[Prueba listado de procedimientos del usuario juandi](https://www.google.com)

### Paso 3
Ejecutamos los 2 procedimientos para que finalmente, inserten esos datos. Lo hacemos con los siguientes bloques plsql
```sql
BEGIN
    XML_MED;
END;
```
[Prueba ejecución correcta procedimiento1](https://www.google.com)

```sql
BEGIN
    XML_INCOMP;
END;
```
[Prueba ejecución correcta procedimiento2](https://www.google.com)
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
[Prueba mostrado de datos de medicamentos](https://www.google.com)  
**Datos XML Incompatibilidades**
```sql
SET LONG 500000000
SET PAGESIZE 50000

SELECT x.xml_data.getClobVal() xml_output
FROM   xml_tab x
WHERE x.id=2;
```
[Prueba mostrado de datos de Incompatibilidades](https://www.google.com)



## Problema 7 (oracle)
(todo el código lo encontrarás en su directorio correspondiente)
