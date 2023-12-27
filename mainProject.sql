CREATE TABLE IF NOT EXISTS books (  /* PLURAL Y ABAJO YA SINGULAR, BUENA PRACTICA QUE CUANDO NO ES TU CÓDIGO MAYUSCULAS Y SI ES TUYO MINUSCULAS, AUNQUE ACEPTE CUALQUIERA */
    `book_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,  /* ENTERO Y QUE SE CREE UN ID DE FORMA INCREMENTAL AUTOMÁTICAMENTE EN CADA FILA, SI SE BORRA UNA FILA SE VA A CREEAR UN EL NÚMERO SIGUIENTE AL ÚLTIMO QUE SE DIÓ, INDEPENTIENDTEMENTE DE QUE SE HAYAN BORRADO FILAS */
    `author_id` INT UNSIGNED,  /* ENTERO Y NO SE PUEDE REPETIR */
    `title` VARCHAR(100) NOT NULL,  /* CADENA CON CIERTA CANTIDAD DE CARACTERES Y QUE SIEMPRE SEA REQUERIDO  */
    `year` INT UNSIGNED NOT NULL DEFAULT 1900,  /* ENTERO, SIN REPETIRSE, REQUERIDO Y SI NO SE LE DA VALOR TIENE UNO POR DEFAULT */
    `language` VARCHAR(2) NOT NULL DEFAULT 'es' COMMENT 'ISO 639-1 Language',  /* CADENA DE 2 CARACTERES,REQUERIDA, POR DEFAULT ES Y CON UN COMENTARIO */
    `cover_url` VARCHAR(500),
    `price` DOUBLE NOT NULL DEFAULT 10.0,  /* TIPO NUMÉRICO BASE DOS, AL DAR DECIMALES REDONDEA Y NO DEJA QUE SEAN DECIMALES LARGOS, CONTRARIO A FLOAT*/
    `sellable` TINYINT DEFAULT 1,  /* TIPO BOOLEANO Y DA UN VALOR POR DEFAULT SI NO SE LE DA NINGUN VALOR */
    `copies` INT NOT NULL DEFAULT 1,
    `description` TEXT  /* TEXTO NORMAL SIN RESTRICCIÓN DE CARACTERES */
);

CREATE TABLE IF NOT EXISTS authors(
    `author_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `nationality` VARCHAR(3)
);

CREATE TABLE IF NOT EXISTS clients(
    `client_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `birthdate` DATETIME,  /* RECUPERA LA FECHA DE ACUERDO AL PAIS DONDE SE ESTA LLENANDO */
    `gender` ENUM('M','F', 'ND') NOT NULL,  /* ENUMERA OPCIONES A ELEGIR, SÓLO PUEDE ELEGIR UNA Y ES REQUERIDA*/
    `active` TINYINT(1) NOT NULL DEFAULT 1,  /* ES BUENA PRÁCTICA TENER UNA COLUMNA CON ESTE NOMBRE PARA ACTIVAR O DESACTIVAR FILAS(INFORMACIÓN), NO SE DEBERÍAN BORRAR */
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  /* SI NO DA UN DATO INSERTA LA HORA DEL SERVIDOR */
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP /* TE DA LA FECHA DE CUANDO SE ACTUALIZÓ LA INFORMACIÓN */
);

CREATE TABLE IF NOT EXISTS operations(
    `operations_id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `book_id` INT UNSIGNED NOT NULL,
    `client_id` INTEGER UNSIGNED NOT NULL,
    `type` ENUM ('V', 'P', 'D') NOT NULL COMMENT 'V: Vendido -P:Prestado -D: Devuelto',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `finished` TINYINT(1) NOT NULL
);

INSERT INTO authors (author_id, name, nationality)  /* INSERTAR INFORMACIÓN O TUPLA A LA TABLA, SE COLOCA ENTRE PARÉNTESIS LOS NOMBRES DE LAS COLUMNAS */
VALUES (NULL, 'Juan Rulfo', 'MEX'); /* Y LUEGO LO VALORES QUE SE VANA A INSERTAR */ /*  */

INSERT INTO authors (name, nationality)
VALUES ('Gabriel García Márquez', 'COL');

INSERT INTO authors 
VALUES (NULL,'Juan Gabriel Vazquez', 'COL');

INSERT INTO authors(name,nationality) /* INSERTAR VARIOS DATOS O TUPLAS A LA VEZ */
VALUES('Julio Cortázar','ARG'),
    ('Isabel Allende', 'CHL'),
    ('Octavio Paz', 'MEX'),
    ('Juan Carlos Onelli', 'URY');

INSERT INTO authors (author_id,name) /* INSERTAR UNA TUPLA CON EL ID QUE YO DESEO */
VALUES(16, 'Pablo Neruda');

INSERT INTO `clients` (client_id, name, email, birthdate, gender, active)
VALUES (1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1);

INSERT INTO `clients` (name, email, birthdate, gender, active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY IGNORE ALL; /* "IGNORE ALL" NUNCA SE RECOMIENDA USAR IGNORE ALL PERO AYUDA A QUE SE HAGAN LAS COSAS SIN QUE TE DE ERRORES*/

INSERT INTO `clients` (name, email, birthdate, gender, active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY UPDATE SET email= ''; /* UPDATE SIRVE PARA CUANDO SE ENCUENTRE UNA KEY DUCPLICADA, ACTUALICE LA TABLA CON ALGUN VALOR EN ESPECÍFICO, LO QUE YA ESTÁ, QUE LO ACTUALICE CON LO QUE YO QUIERO*/

INSERT INTO `clients` (name, email, birthdate, gender, active)
VALUES ('Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0)
ON DUPLICATE KEY UPDATE active= VALUES(active); /* UPDATE SIRVE PARA CUANDO SE ENCUENTRE UNA KEY DUCPLICADA, ACTUALICE LA TABLA CON EL VALOR DADO EN ESA SENTENCIA O DEFECTO, LO QUE YA ESTÁ, QUE LO ACTUALICE CON LO QUE YO QUIERO */

/* *************SIMULACIÓN DE UN ARCHIVO CSV */
El Laberinto de la Soledad, Octavio Paz, 1952
Vuelta al Laberinto de la Soledad, Octavio Paz, 1960

/* ***********SENTENCIAS */
INSERT INTO books(title, author_id) /* INSERTA UNA TUPLA EN LA TABLA DE LIBROS ASOCIADA AL ID DEL AUTOR 6 (Octavio Paz) */
VALUES ('El Laberinto de la Soledad', 6);

INSERT INTO books(title, author_id, year) /* ****SUBQUERY O QUERIES ANIDADOS****** INSERTA UNA TUPLA DANDOLE EL VALOR DEL ID DEL AUTOR OBTENIDO DE LA SELECCIÓN DE LA TABLA AUTORES CON EL NOMBRE "Octavio Paz" Y DÁNDOLE COMO LÍMITE QUE SÓLO ME DE UNA TUPLA. SE DEBE TENER CUIDADO CON ELLOS PORQUE PUEDE HACER LENTA LA CARGA DE LA COMPUTADORA, PODEMOS METER DATOS INCORRECTOS YA QUE SE EJECUTA SI O SI*/
VALUES ('Vuelta al Laberinto de la Soledad',
    (SELECT author_id FROM authors WHERE name = 'Octavio Paz' LIMIT 1),
    1960);

/* SELECT */ /*  */
SELECT name, email, gender
FROM clients 
WHERE gender = 'F'; /* SELECIONA LAS CLIENTAS */

SELECT year(birthdate)
FROM clients; /* TRAE SÓLO EL AÑO DE LOS CUMPLEAÑOS DE LOS CLIENTES */

SELECT year(NOW()) - year(birthdate)
FROM clients; /* TRAE LA EDAD DE LOS CLIENTES */

SELECT name, year(NOW()) - year(birthdate)
FROM clients; /* TRAE LA EDAD Y NOMBRE DE LOS CLIENTES */

SELECT * FROM clients
WHERE name LIKE '%Saave%'; /* TRAE TODOS LOS CLIENTES QUE EN SU NOMBRE CONTENGAN LO QUE ESTA ENTRE COMILLAS. EL % INDICA QUE NO IMPORTA LO QUE ESTE ANTES O DESPUÉS DE EL */

SELECT name, email, YEAR(NOW()) - YEAR(birthdate) AS edad, gender
FROM clients
WHERE gender = 'F'
AND name LIKE '%Lop%'; /* TRAER LA INFORMACIÓN DE LOS CLIENTES DE LAS COLUMNAS SELECCIONADAS, CREA EN EL RESULTADO LA COLUMNA EDAD Y FILTRA SÓLO A LAS MUJERES Y QUE TENGAN LOP EN SU NOMBRE*/

/* CRUZAR LAS TABLAS */ /*  */
SELECT * FROM authors
WHERE author_id >0 AND author_id <= 5; /* SELECCIONA LOS AUTORES CON ID DEL 1-5 */

SELECT * FROM books
WHERE author_id BETWEEN 1 AND 5; /* SELECCIONA LOS LIBROS CON AUTORES QUE TENGAN EL ID DEL 1-5 */

SELECT book_id, author_id, title
FROM books
WHERE author_id BETWEEN 1 AND 5;

SELECT b.book_id, a.name, a.author_id, b.title /* LAS COLUMNAS COMPARTIDAS DE LAS TABLAS CRUZADAS DA IGUAL A CUÁL TABLA HAGAS REFERENCIA */
FROM books AS b /* ALIAS PARA REFERIRTE A UNA TABLA */
JOIN authors AS A /* JOIN ES LO MISMO QUE INNER */
    ON a.author_id = b.author_id
WHERE a.author_id BETWEEN 1 AND 5; 

SELECT c.name, b.title, t.type /* UNE TRES TABLAS, USANDO COMO PIVOTE LA TABLA DE TRANSACTIONS */
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id;

SELECT c.name, b.title, a.name, t.type /* UNE TRES TABLAS, USANDO COMO PIVOTE LA TABLA DE TRANSACTIONS */
FROM transactions AS t
JOIN books AS b
    ON t.book_id = b.book_id
JOIN clients AS c
    ON t.client_id = c.client_id
JOIN authors AS a
    ON b.author_id = a.author_id
WHERE c.gender='M' 
    AND t.type IN ('sell', 'lend');/* VARIAS OPCIONES */

SELECT b.title, a.name /* JOIN IMPLICITO */
FROM authors AS a, books AS b
WHERE a.author_id = b.author_id
LIMIT 10;

SELECT b.title, a.name /* QUERY IGUAL AL ANTERIOR Mejor opción al ser mas descriptivo*/
FROM books AS b
INNER JOIN authors AS a 
ON a.author_id = b.author_id
LIMIT 10;

SELECT a.author_id, a.name, a.nationality, b.title
FROM authors AS a
JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC; /* ORDENA LOS ELEMENTOS, SI NO PONGO NADA ME LO PONE EN ASCENDENTE ASÍ LOS HACE EN DESCENDENTE*/

SELECT a.author_id, a.name, a.nationality, b.title /* LEFT JOIN ME TRAE TODO LO DE LA TABLA PIVOTE AUNQUE NO HAYA COINCIDENCIAS Y LUEGO LE AÑADE LO QUE YO QUIERA UNIRLE */
FROM authors AS a
LEFT JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
ORDER BY a.author_id DESC;

SELECT a.author_id, a.name, a.nationality,
COUNT(b.book_id) 
FROM authors AS a
RIGHT JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id 
ORDER BY a.author_id;

SELECT a.author_id, a.name, a.nationality, /* QUERY QUE ME DICE CUÁNTOS LIBROS TIENE CADA AUTOR AUNQUE NO TENGA NINGUNO */
COUNT(b.book_id) /* SABER CUÁNTOS VALORES DISTINTOS HAY */
FROM authors AS a
LEFT JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id /* AGRUPARLOS POR ESTE PARÁMETRO, PARÁMETRO PIVOTE Me va a hacer la sumatoria para que me diga cuántos libros tiene ese autor */
ORDER BY a.author_id;

SELECT a.author_id, a.name, a.nationality, /* QUERY QUE ME DICE CUÁNTOS LIBROS TIENE CADA AUTOR, SÓLO LOS QUE TENGAN ALGÚN LIBRO */
COUNT(b.book_id) 
FROM authors AS a
IINNER JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id 
ORDER BY a.author_id;

SELECT a.author_id, a.name, a.nationality, /* NO FUNCIONA */
COUNT(b.book_id) 
FROM authors AS a
FULL OUTER JOIN books AS b
ON b.author_id = a.author_id
WHERE a.author_id BETWEEN 1 AND 5
GROUP BY a.author_id 
ORDER BY a.author_id;

SELECT * /* ASI FUNCIONA EL FULL OUTER JOIN FUNCIONA */
FROM authors as a
LEFT JOIN books as b 
	ON a.author_id = b.author_id
WHERE b.author_id IS NULL
UNION
SELECT *
FROM authors as a
RIGHT JOIN books as b 
	ON a.author_id = b.author_id
WHERE a.author_id IS NULL;

/* QUERY ANIDADO... tabla con dos columnas:
-Derecha "CANTIDAD_LIBROS_ESCRITOS", enumera cantidades.
-Izquierda "CANTIDAD_AUTORES", autores que han escrito la cantidad de libros de la columna de la derecha. */
SELECT COUNT(ID) AS CANTIDAD_AUTORES, CANTIDAD AS CANTIDAD_LIBROS_ESCRITOS
FROM (SELECT a.author_id AS ID, a.name AS NOMBRE, COUNT(b.book_id) AS CANTIDAD
FROM authors AS a
LEFT JOIN books AS b
ON a.author_id = b.author_id
GROUP BY a.author_id
ORDER BY a.author_id) AS TABLA_SECUNDARIA
GROUP BY CANTIDAD_LIBROS_ESCRITOS
ORDER BY CANTIDAD_LIBROS_ESCRITOS


/* ***********CASOS DE NEGOCIO */
-- ¿Qué nacionalidades hay? 
SELECT DISTINCT nationality
FROM authors;

SELECT nationality
FROM authors
WHERE nationality IS NOT NULL
GROUP BY nationality
ORDER BY nationality;

-- ¿Cuantos escritores hay de cada nacionalidad? 
SELECT nationality, COUNT(author_id) AS c_authors
FROM authors
GROUP BY nationality
ORDER BY c_authors DESC, nationality ASC; /*ORDENA PRIMERO POR UN PARÁMETRO Y LUEGO POR EL OTRO*/

SELECT nationality, COUNT(*) AS quantity_of_authors
FROM authors
GROUP BY nationality
ORDER BY nationality;

SELECT nationality, COUNT(*) AS quantity_of_authors
FROM authors
WHERE nationality IS NOT NULL /* NO TRAE LAS NULL */
AND nationality NOT IN('RUS', 'AUT') /* QUITA CIERTOS VALORES QUE NO QUIERES QUE TE INCLUYA */
GROUP BY nationality
ORDER BY nationality;

SELECT nationality, COUNT(*) AS quantity_of_authors
FROM authors
WHERE nationality IS NOT NULL /* NO TRAE LAS NULL */
AND nationality IN('RUS', 'AUT') /* SOLO TRAE LOS VALORES QUE QUIERES QUE TE INCLUYA */
GROUP BY nationality
ORDER BY nationality;

SELECT nationality, COUNT(*) AS quantity_of_authors
FROM authors
WHERE nationality IS NOT NULL /* NO TRAE LAS NULL */
GROUP BY nationality
ORDER BY nationality;

-- ¿Cuantos libros hay de cada nacionalidad? 
SELECT nationality, COUNT(*) AS quantity_of_books
FROM books AS b 
LEFT JOIN authors AS a
    ON b.author_id = a.author_id
GROUP BY nationality; 

-- ¿Cuál es el promedio/desviación estándar del precio de libros? 
SELECT AVG(price) 
FROM books; 

SELECT AVG(price) 
AS `promedio` /* como quiero que se llame la columna */
FROM books; 

SELECT AVG(price) AS `PROM`,
STDDEV(price) AS `STD`/* desviación estandar */
FROM books;

-- ¿Cuál es el promedio/desviación estándar del precio de libros por nacionalidad? 
SELECT nationality,
COUNT(book_id) AS `Libros`,
AVG(price) AS `Prom`,
STDDEV(price) AS `Std`
FROM books AS b
JOIN authors AS a
    ON a.author_id = b.author_id
GROUP BY nationality
ORDER BY `Libros` DESC;

-- ¿Cuál es el promedio/desviación estándar de la cantidad de autores por nacionalidad?
SELECT AVG(quantity_of_authors) as prom_by_nationality FROM
    (SELECT COUNT(*) AS quantity_of_authors
    FROM authors
    GROUP BY nationality) 
    AS quantity_of_authors_by_nationality;

SELECT STDDEV(quantity_of_authors) as standard_deviation_by_nationality FROM
    (SELECT COUNT(*) AS quantity_of_authors
    FROM authors
    GROUP BY nationality) 
    AS quantity_of_authors_by_nationality;  

-- ¿Cuál es el precio máximo y mínimo de un libro?
SELECT MAX(price) AS Max_price,
MIN(price) AS Min_price
FROM books;

SELECT price AS max_price FROM books
ORDER BY price DESC
LIMIT 1;

SELECT price AS min_price FROM books
WHERE price IS NOT NULL
ORDER BY price ASC
LIMIT 1; 

SELECT nationality,
MAX(price),
MIN(price) 
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
GROUP BY nationality;

-- ¿Cómo quedaría el reporte de préstamos?
SELECT c.name, t.type, b.title,
CONCAT(a.name, "(", a.nationality, ")") AS autor, /* concatena dos columnas en una sola */
TO_DAYS(NOW()) - TO_DAYS(t.created_at) AS ago /* opetación aritmética para saber hace cuantos días se creo */
FROM transactions AS t
LEFT JOIN clients AS c
  ON c.client_id = t.client_id
LEFT JOIN books AS b
  ON b.book_id = t.book_id
LEFT JOIN authors AS a
  ON b.author_id = a.author_id;

SELECT TO_DAYS(NOW()) /*trae los días desde el día 0 del año cero hasta hoy.*/

SELECT TO_DAYS('0000-01-01'); /*el día uno*/


/* ***********UPDATE Y DELETE */
SELECT *
FROM authors
ORDER BY rand()
LIMIT 10; /* seleccionar 10 elementos de la tabla autores al azar */

-- DELETE: borra el registro.
-- Adicionalmente filtrar con WHERE por id y limitarlo para que nos borre la cantidad elementos en específico y no toda la tabla o más elementos.
DELETE FROM authors WHERE author_id = 161 LIMIT 1;

-- UPDATE: actualizar datos de una tupla existente.
-- También se debe filtrar con WHERE
UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1;

SELECT COUNT(*) /* contar cuantos elementos tengo dentro de la tabla */
FROM authors;

SELECT client_id, name 
FROM clients
WHERE active <> 1; /* <> significa que es diferente */

SELECT client_id, name, active 
FROM clients order by rand() 
LIMIT 10; /* en está sentencia RAND() permite ordenar de forma aleatoria, no recomendado hacerlo en producción. */

SELECT client_id, name, email, active 
FROM clients
WHERE client_id IN (80,65,76,1,61,7,19,97); /* traer ciertos elementos específicos*/

/*Al hacer un update es MUY IMPORTANTE que tenga un WHERE para ser específico y que no se duplique la data*/
UPDATE clients
SET active = 0
WHERE client_id = 80
LIMIT 1; /* actualizar elemento en específico */

UPDATE clients
SET email = 'javier@gmail.com'
WHERE client_id = 7
OR client_id = 19; /* actualizar elementos con ciertas condiciones en específco*/

SELECT client_id, name, email, active 
FROM clients
WHERE client_id IN (1,6,8,27,90)
  OR NAME like '%Lopez%';

UPDATE clients
SET active = 0
WHERE client_id IN (1,6,8,27,90)
  OR NAME like '%Lopez%';/* actualizar elementos con ciertas condiciones en específco*/

SELECT *
FROM transactions;

-- TRUNCATE: Borra todo el contenido de una tabla CUIDADO
TRUNCATE transactions;


/* ***********SUPER QUERY */
SELECT DISTINCT nationality
FROM authors;

UPDATE authors 
SET nationality = 'GBR'
WHERE nationality = 'ENG';

SELECT COUNT(*) /* cuenta todo lo que haya */
FROM books;

SELECT COUNT(book_id) /* mas seguro */
FROM books;

SELECT SUM(price) /*suma de libros vendidos unitariamente*/
FROM books
WHERE sellable =1;

SELECT SUM(price*copies) /*suma total de ventas*/
FROM books
WHERE sellable =1;

SELECT sellable,
SUM(price*copies) /*suma total de ventas y no vendidos*/
FROM books
GROUP BY sellable;

SELECT COUNT(book_id),
SUM(IF(year < 1950, 1, 0))
AS '<1950'
FROM books;

SELECT COUNT(book_id),
SUM(IF(year < 1950, 1, 0))
AS '<1950'
SUM(IF(year <1950, 0, 1))
AS '<1950'
FROM books;

SELECT COUNT(book_id),
SUM(IF(year < 1950, 1, 0))
AS '<1950',
SUM(IF(year >=1950 AND year < 1990, 1, 0))
AS '>1990',
SUM(IF(year >=1990 AND year < 2000, 1, 0))
AS '<2000',
SUM(IF(year >=2000, 1, 0))
AS '<HOY'
FROM books;

SELECT nationality,
COUNT(book_id),
SUM(IF(year < 1950, 1, 0))
AS '<1950',
SUM(IF(year >=1950 AND year < 1990, 1, 0))
AS '>1990',
SUM(IF(year >=1990 AND year < 2000, 1, 0))
AS '<2000',
SUM(IF(year >=2000, 1, 0))
AS '<HOY'
FROM books AS b
JOIN authors AS a
ON a.author_id = b.author_id
WHERE a.nationality IS NOT NULL
GROUP BY nationality;