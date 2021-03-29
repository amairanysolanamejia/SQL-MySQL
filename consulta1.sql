SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender 
FROM clients WHERE gender = 'F' AND name LIKE '%Lop%';

--JOINS
/*Quier relacionar el nombre del autor, el títilo del libro, por lo que usarémos JOIN*/
SELECT b.book_id, a.name , b.title
FROM books as b
JOIN authors as a
ON a.author_id = b.author_id
WHERE a.author_id between 1 and 5;
/* books es la tabal pivote
join es lo mismo que inner join
on es en qué campos se van a relaiconar estas tablas
el author_id de la tabla authors u el author_id de la tabla books
queremos el id del autor entre 1 y 5*/
SELECT b.book_id, a.name, a.author_id , b.title
FROM books as b
JOIN authors as a
ON a.author_id = b.author_id
WHERE a.author_id between 1 and 5;

---JOIN para la tabla de transactions

SELECT  c.name,  b.title, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id;

/*ahora en vez de ver book_id y client_id 
vemos nombre del cliente, título del libro y el estado del libro*/
--ponemos varias condiciones
SELECT  c.name,  b.title, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
WHERE c.gender = 'F'
AND t.type = 'sell'
;
-- ahora incluimos los autores
SELECT  c.name,  b.title, a.name, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a 
ON b.author_id = a.author_id
WHERE c.gender = 'F'
AND t.type = 'sell'
;
-- queremos que se muestren las opciones sell y lend
SELECT  c.name,  b.title, a.name, t.type
FROM transactions as t
JOIN books as b
ON t.book_id = b.book_id
JOIN clients as c
ON t.client_id = c.client_id
JOIN authors as a 
ON b.author_id = a.author_id
WHERE c.gender = 'M'
AND t.type IN ( 'sell', 'lend')
;

--  JOIN y order by (por defecto es ASC)
SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
  ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC;

-- LEFT JOIN

SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
LEFT JOIN books AS b
  ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id;

-- LEFT JOIN
--Contar número de libros tiene un autor.
-- Con COUNT (contar), es necesario tener un GROUP BY (agrupado por un criterio)
SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors AS a
LEFT JOIN books AS b
  ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id;

SELECT a.author_id, a.name, a.nationality, COUNT(b.book_id)
FROM authors AS a
RIGHT JOIN books AS b
  ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id
ORDER BY a.author_id;