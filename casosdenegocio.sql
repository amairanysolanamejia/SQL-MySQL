-- 1.- Qué nacionalidades hay
SELECT nationality, COUNT(nationality) FROM authors
GROUP BY nationality;
--otra manera
SELECT DISTINCT nationality  FROM authors
ORDER BY nationality;

--2 ¿Cuántos escritores hay de cada nacionalidad
SELECT nationality, COUNT(author_id) as numero_autores FROM authors
GROUP BY nationality
ORDER BY numero_autores DESC
;
--se pueden eliminar las consultas con NULL si se agrega:
-- WHERE nationality IS NOT NULL antes de group by
--si no quisiera mostrar un país en específico debajo del WHERE pongo
-- AND nationality NOT IN ('RUS', 'ENG')

--3. ¿Cuántos libros hay de cada nacionalidad?

SELECT nationality, COUNT(b.book_id) as numero_libros
FROM books as b
JOIN authors as a 
ON  a.author_id = b.author_id
GROUP BY (nationality);

-- 4. ¿Cuál es el promedio/desviación estandar del preico de lso libros?

SELECT AVG(price) FROM books; -- promedio del precio
SELECT AVG(price) , STDDEV(price)FROM books; 

--5. ¿Cuál es le precio máximo/mínimo de un libro
select MIN(price) from books;
select MAX (price) from books;

-- 6.- ¿Cómo quedaría el reporte de préstamos?
select type, count(type) from transactions group by type;
-- una manera más completa
SELECT c.name, t.type, b.title,
CONCAT (a.name, " (", a.nationality, ")") AS autor,
TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS ago
FROM transactions AS t
LEFT JOIN clients AS c
ON c.client_id = t.client_id
LEFT JOIN books AS b
ON b.book_id = t.book_id
LEFT JOIN authors AS a
ON b.author_id = a.author_id;

--UPDATE y DELETE
--Atualizar: datos equivocados o cuando se cambia el inventario
-- mostramos la tabla: select client_id,name, email from clients where client_id in (2,4,6,7,8,10);
update clients set email ='javier@gmail.com' where client_id = 7 limit 1;
-- cambiar el estado de activo a inactivo (0)
-- select client_id,name, email from clients where client_id in (2,4,6,7,8,10);
UPDATE clients set active = 0 where client_id IN (2,6,8);

-- Super Querys
-- se pueden poner condicionales
--s e busca una matriz que dependa d e os años y de la nacionalidad
SELECT COUNT(book_id) , SUM(IF(YEAR < 1950,1,0)) AS '< 1950' 
FROM books;-- selecciona el númeor de libros que estén publicados antes de 1950
-- if(condicion, se cumple, no se cumple)
SELECT COUNT(book_id) , SUM(IF(YEAR < 1950,1,0)) AS '< 1950' , 
SUM(IF(YEAR <= 1950,0,1)) AS '>= 1950'  FROM books;
--lo anterior muestra por separado las columnas de los libros publicados antes y después de 1950
SELECT COUNT(book_id) , SUM(IF(YEAR < 1950,1,0)) AS '< 1950' , 
SUM(IF(YEAR >= 1950 AND YEAR < 1990,1,0)) AS '< 1990',  
SUM(IF(YEAR >= 1990 AND YEAR < 2000,1,0)) AS '< 2000' , 
SUM(IF(YEAR >= 2000 ,1,0)) AS '> 2000' 
FROM books; -- lo dividimos aún más 

--ahora en la siguiente línea viene la magia
--además de ordenar por año, se ordena por nacionalidad
SELECT nationality,COUNT(book_id) , 
SUM(IF(YEAR < 1950,1,0)) AS '< 1950' , 
SUM(IF(YEAR >= 1950 AND YEAR < 1990,1,0)) AS '< 1990',  
SUM(IF(YEAR >= 1990 AND YEAR < 2000,1,0)) AS '< 2000' , 
SUM(IF(YEAR >= 2000 ,1,0)) AS '> 2000' 
FROM books AS b INNER JOIN authors AS a ON
b.author_id = a.author_id
WHERE nationality IS NOT NULL
GROUP BY nationality ; 