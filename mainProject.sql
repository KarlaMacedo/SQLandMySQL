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