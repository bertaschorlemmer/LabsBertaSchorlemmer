CREATE DATABASE IF NOT EXISTS TikTokDB;

USE TikTokDB;

CREATE TABLE IF NOT EXISTS usuarios (
	id_usuario INT NOT NULL UNIQUE,
    nombre VARCHAR (100),
    correo VARCHAR (100),
    fecha date,
    pais VARCHAR (100) NOT NULL,
    PRIMARY KEY (id_usuario)) ;
    
    CREATE TABLE IF NOT EXISTS videos (
    id_video INT NOT NULL UNIQUE,
    id_usuario INT,
    titulo VARCHAR (100),
    descripcion VARCHAR (100),
    fecha DATE,
    duracion TIME,
	CONSTRAINT fk_usuarios_videos
	FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario));
    
	CREATE TABLE IF NOT EXISTS comentarios (
    id_comentario INT NOT NULL UNIQUE,
    id_usuario INT,
    id_video INT,
    texto VARCHAR (100),
    fecha DATE,
	CONSTRAINT fk_usuarios_videos_comentarios
	FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
    FOREIGN KEY (id_video) REFERENCES videos (id_video));
    

CREATE TABLE IF NOT EXISTS likes (
    id_like INT PRIMARY KEY AUTO_INCREMENT,   
    id_video INT NOT NULL,                   
    id_usuario INT NOT NULL,                  
    fecha DATE NOT NULL,  
    CONSTRAINT fk_usuarios_videos_likes
    FOREIGN KEY (id_video) REFERENCES Videos(id_video),      
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) 
);

CREATE TABLE IF NOT EXISTS seguidores (
    id_seguidor INT PRIMARY KEY AUTO_INCREMENT,  
    id_usuario_seguidor INT NOT NULL,             
    id_usuario_seguido INT NOT NULL,             
    fechainicio DATE NOT NULL,                  
    CONSTRAINT fk_usuario_seguidor 
    FOREIGN KEY (id_usuario_seguidor) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_usuario_seguido) REFERENCES Usuarios(id_usuario)
);

INSERT INTO usuarios (id_usuario, nombre, correo, pais)
VALUES
  (1, 'Sofia Fontanals', 'sofia.fontanals@ironhack.com', 'España'),
  (2, 'Andrea Maristany', 'andrea.maristany@ironhack.com', 'España'),
  (3, 'Hugo Morgado', 'hugo.morgado@ironhack.com', 'Croacia'),
  (4, 'Pati Durall', 'pati.durall@ironhack.com', 'España'),
  (5, 'Merce Lainas', 'merce.lainas@ironhack.com', 'Francia');
  
  
INSERT INTO Videos (id_video, id_usuario, titulo, descripcion, fecha, duracion)
VALUES
  (1, 1, 'Receta fácil de pasta', 'cocina',  '2023-09-01', 30),
  (2, 2, 'Baile viral en TikTok', 'tiktok', '2023-09-02', 45),
  (3, 3, 'Tutorial SQL básico', 'informatica', '2023-09-05', 33),
  (4, 4, 'Vlog en Ironhack', 'vlog', '2023-09-06', 24),
  (5, 5, 'Tips de productividad', 'consejos', '2023-09-07', 20);
  
  INSERT INTO Comentarios (id_comentario, id_usuario, id_video, texto, fecha)
VALUES
  (1, 1, 2, '¡Qué buena receta!', '2023-09-01'),
  (2, 2, 3, 'Ese baile es brutal ', '2023-09-03'),
  (3, 3, 1, 'Muy útil, gracias!', '2023-09-05'),
  (4, 4, 5, 'Me encantó el vlog ', '2023-09-06'),
  (5, 5, 4, 'Tomando nota de los tips', '2023-09-07');
  
INSERT INTO likes (id_like, id_video, id_usuario, fecha)
VALUES
  (1, 1, 3, '2023-09-01'),
  (2, 1, 4, '2023-09-02'),
  (3, 2, 5, '2023-09-03'),
  (4, 3, 2, '2023-09-05'),
  (5, 5, 1, '2023-09-07');

INSERT INTO seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fechainicio)
VALUES
  (1, 2, 1, '2023-08-25'), 
  (2, 3, 2, '2023-08-30'), 
  (3, 4, 3, '2023-09-01'), 
  (4, 5, 4, '2023-09-03'), 
  (5, 1, 5, '2023-09-05');
    
-- ver todos los usuarios de tiktok

SELECT * FROM usuarios;

-- ver todos los vídeos publicados

SELECT * FROM videos;

-- ver comentarios realizados en los videos

SELECT * FROM comentarios;

-- ver los likes dados a los videos

SELECT * FROM likes;

-- ver relaciones de seguimineto entre los usuarios

SELECT * FROM seguidores;

-- 3 QUERIES MAS
-- 1: ver el comentario mas largo

SELECT texto FROM comentarios
ORDER BY LENGTH(texto) DESC
LIMIT 1;

-- ensenya los videos publicados por Sofia

SELECT titulo
FROM Videos
WHERE id_usuario = 1;

-- id de los seguidores de Andrea

SELECT id_usuario_seguidor
FROM Seguidores
WHERE id_usuario_seguido = 2;




    
    
    
    
    

    
    
    

    
    
    
    
    
    



