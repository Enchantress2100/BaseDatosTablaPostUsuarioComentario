--crear base de datos blogs, resetearla si es que ya existe.
DROP DATABASE blogs IF EXISTS;
CREATE DATABASE blogs;

--acceder desde consola a la base de datos blogs
\c blogs

--crear tablas
CREATE TABLE usuario(
    email VARCHAR(100) UNIQUE,
    id INT,
    PRIMARY KEY (id)
);
--visualizar
--SELECT id, email FROM usuario;

--usar si es necesario
--DROP TABLE usuario;
--DROP TABLE post;
--DROP TABLE comentario;

CREATE TABLE post(
    titulo VARCHAR(100),
    fecha DATE,
    id INT,
    usuario_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);
--visualizar
SELECT * FROM post;

CREATE TABLE comentario(
    texto VARCHAR(250),
    fecha DATE,
    id INT,
    post_id INT,
    usuario_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (post_id) REFERENCES post(id)
);

--visualizar
SELECT * FROM comentario;

--insertar datos en tabla usuario

INSERT INTO usuario(email,id) 
VALUES('usuario01@hotmail.com',1);

INSERT INTO usuario(email, id) 
VALUES('usuario02@gmail.com',2);

INSERT INTO usuario(email, id) 
VALUES('usuario03@gmail.com',3);

INSERT INTO usuario(email, id) 
VALUES('usuario04@hotmail.com',4);

INSERT INTO usuario(email, id) 
VALUES('usuario05@yahoo.com',5);

INSERT INTO usuario(email, id)
VALUES('usuario06@hotmail.com',6);

INSERT INTO usuario(email, id) 
VALUES('usuario07@yahoo.com',7);

INSERT INTO usuario(email, id) 
VALUES('usuario08@yahoo.com',8);

INSERT INTO usuario(email, id) 
VALUES('usuario09@yahoo.com',9);


--insertar datos en tabla post

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(1,1,'Post 1: Esto es malo', '2020-06-29');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(2,5,'Post 2: Esto es malo', '2020-06-20');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(3,1,'Post 3: Esto es excelente', '2020-05-30');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(4,9,'Post 4: Esto es bueno', '2020-05-09');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(5,7,'Post 5: Esto es bueno', '2020-07-10');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(6,5,'Post 6: Esto es excelente', '2020-07-18');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(7,8,'Post 7: Esto es excelente', '2020-07-07');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(8,5,'Post 8: Esto es excelente', '2020-05-14');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(9,2,'Post 9: Esto es bueno', '2020-05-08');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(10,6,'Post 10: Esto es bueno', '2020-06-02');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(11,4,'Post 11: Esto es bueno', '2020-05-05');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(12,9,'Post 12: Esto es malo', '2020-07-23');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(13,5,'Post 13: Esto es excelente', '2020-05-30');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(14,8,'Post 14: Esto es excelente', '2020-05-01');

INSERT INTO post(id, usuario_id, titulo, fecha)
VALUES(15,7,'Post 15: Esto es malo', '2020-06-17');

--insertar datos en tabla comentario
INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(1,3,6, 'Este es el comentario 1', '2020-07-08');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(2,4,2, 'Este es el comentario 2', '2020-06-07');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(3,6,4, 'Este es el comentario 3', '2020-06-16');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(4,2,13, 'Este es el comentario 4', '2020-06-15');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(5,6,6,'Este es el comentario 5','2020-05-14');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(6,3,3,'Este es el comentario 6', '2020-05-22');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(7,6,1,'Este es el comentario 7', '2020-05-22');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(8,6,7,'Este es el comentario 8', '2020-07-09');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(9,8,13, 'Este es el comentario 9','2020-06-30');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(10,8,6, 'Este es el comentario 10', '2020-06-19');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(11,5,1, 'Este es el comentario 11', '2020-05-09');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(12,8,15, 'Este es el comentario 12', '2020-06-17');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(13,1,9,'Este es el comentario 13', '2020-05-01');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(14,2,5, 'Este es el comentario 14', '2020-05-31');

INSERT INTO comentario(id, usuario_id, post_id,texto, fecha)
VALUES(15,4,3, 'Este es el comentario 15', '2020-06-28');

--seleccionar el correo, id y titulo de todos los post publicados por el usuario 5.

SELECT x.email, y.id, y.titulo
FROM usuario as x
INNER JOIN post as y
ON x.id=y.usuario_id
WHERE usuario_id = 5;

--listar correo, id y detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@gmail.com

SELECT x.email, j.id, j.texto
FROM usuario as x
INNER JOIN comentario as j 
ON x.id=j.usuario_id
WHERE usuario_id IN(1,2,3,4,7,8,9)
ORDER BY id;

--listar los usuarios que no han realizado ningun post

SELECT * FROM usuario
LEFT JOIN post
ON usuario.id=post.usuario_id
WHERE post IS NULL
ORDER BY email; 

--listar todos los post con sus comentarios, aunque no los tengan.

SELECT * FROM post
FULL OUTER JOIN comentario
ON post.usuario_id=comentario.usuario_id
ORDER BY post.titulo;

--listar todos los usuarios que hayan hecho un post en JUNIO.

SELECT x.email, y.titulo, y.fecha
FROM usuario as x
INNER JOIN post as y
ON x.id=y.usuario_id
WHERE y.fecha BETWEEN '2020-06-01' AND '2020-06-30';


