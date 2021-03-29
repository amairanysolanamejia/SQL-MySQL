# SQL-MySQL

_Implementación de una base de datos de una librería en MySQL, donde se incluye el autor (nombre y nacionalidad ), libros (autor, título, año, idioma, portada, etc.), clientes y transacciones.
Los scripts contienen el código necesario para realizar inserción, consulta, filtrado y casos de negocio._

## Comenzando 🚀

_Estas instrucciones te permitirán obtener utilizar este proyecto en tu máquina local._

### Instalación 🔧

_El proyecto se realizó en MySQL en Ubuntu 18.04.5, por lo que la manera de isntalarlo desde consola es:_


```
sudo apt install mysql-server
```
_Para correr la consola de MySQL, simplemente corren el comando:_
```
sudo mysql
```


### Comandos básicos para SQL ⌨️

_Los comandos básicos y algunos específicos para el presente proyecto son:_
_MySQL desde consola_

```
ctrol + L --borramos lo anterior en la pantalla

show databases;    --mostramos cuáles bases de datos tenemos

use nombredelabasededatos;  --usamos esa base de datos

show tables;    --mostramos las tablas de la base de datos

select  database();   --mostramos en qué base de datos estamos

describe authors; --muestra las características de la tabla

show full columns from books; --mostramos todas las columnas, aunque se ve desordenado

sudo mysql  < script_esquema.sql   --cargamos tablas (script_esquema.sql)desde terminal , es sólo el esquema, sin datos

sudo mysql  -D nombredeasededatos < script_datos.sql  --cargamos  datos (script_datos.sql) desde terminal
```

_SELECT_
```
select * from clients;

select name from clients;

select name, email, gender from clients;

--condicionar
select name, email, gender from clients limit 10; Muestra  10 clientes

select name, email, gender from clients where gender = ‘M’; --mostramos todos los hombres

select birthdate from clients;

select year(birthdate) from clients; --traemos el año en que nace cada persona

select NOW() --traemos la fecha de hoy

select YEAR(NOW()) - YEAR(birthdate) FROM clients limit 10; --mostramos la edad de los clientes

select name, YEAR(NOW()) - YEAR(birthdate) FROM clients limit 10; muestra la edad de los clientes y su nombre

select  * from clients where name like ‘%Saave%’; --buscamos nombres de clientes que tengan Saave

select name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender
FROM clients WHERE gender = 'F' AND name LIKE '%Lop%';  -- mostramos los nombres, el email,  la edad y el género de personas que contengan en su nombre la palabra “Lop”

select count (*) from books; --mostramos el número total de libros

select * from authors where author_id >0 and author_id <=5; --mostramos los autores con id entre 1 y 5

select * from books where author_id >0 and author_id <=5;

select  book_id, author_id, title from books where author_id >0 and author_id <=5;

select AVG(price) FROM books;

select AVG(price) , STDDEV(price)FROM books; --mostramos promedio y desviación estandar

select TO_DAYS(NOW()) --decimos cuántos días han pasado desde que se crearon las computadoras

select * from authors order by rand() limit 10 --mostramos aleatoriamente los datos de authors, no es muy eficiente, pero para cosas pequeñas funcionan

delete from authors where author_id = 161 limit 1 --borramos el autor 161

update  clients set  active = 0 where client_id = 80  limit 1;  -- actualizamos un dato, se vuelve inactive

update clients set email = ‘javier@gmail.com’ where client_id = 7 limit 1; --cambiamos el email por algo diferente

select client_id, name from clients where client_od IN (1,5,6,8,9); --mostramos el id y el nombre con el id 1,5,6,78,9

truncate transaction; --borramos tooodo de la tabla transaction

select SUM(price) FROM books WHERE sellable = 1; -- mostramos la suma de todos los libros vendidos

select SUM(price*copies) FROM books WHERE sellable = 1; -- mostramos la suma de los libros vendidos por cada copia

select COUNT(book_id) , SUM(IF(YEAR < 1950,1,0)) AS '< 1950' , SUM(IF(YEAR <= 1950,0,1)) AS '>= 1950'  FROM books; -- seleccionamos el número de libros que estén publicados antes de 1950 -- if(condicion, se cumple, no se cumple)

alter table authors add column birthyear integer default 1930 after name; --añadimos una columna a la tabla authors

alter table authors modify column birthyear integer default 1930;

show tables like ‘%i%’ -- mostramos las tabals que contengan una i en el nombre

```
## Notas :mega:
_Siendo muy estrictos, las palabras reservadas del lenguaje van en mayúsculas, así que tómalo en cuenta_

## Referencias ✒️

_Estos apuntes se basaron en el curso de SQL y MySQL de Platzi :green_heart:, impartido por Alberto Alcocer._




