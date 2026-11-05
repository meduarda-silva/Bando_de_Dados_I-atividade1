    -- 1. Tabela planos (sem dependências)
    CREATE TABLE IF NOT EXISTS planos (
        id_plano INTEGER PRIMARY KEY,
        preco_plano DECIMAL(8,2)
    );

    -- 2. Tabela usuarios (depende de planos)
    CREATE TABLE IF NOT EXISTS usuarios (
        id_usuario INTEGER PRIMARY KEY,
        email_usuario VARCHAR(120),
        id_plano INTEGER,
        CONSTRAINT fk_usuarios_planos 
            FOREIGN KEY (id_plano) REFERENCES planos(id_plano)
    );

    -- 3. Tabela diretores (sem dependências)
    CREATE TABLE IF NOT EXISTS diretores (
        id_diretor INTEGER PRIMARY KEY,
        nome_diretor VARCHAR(80)
    );

    -- 4. Tabela generos (sem dependências)
    CREATE TABLE IF NOT EXISTS generos (
        id_genero INTEGER PRIMARY KEY,
        nome_genero VARCHAR(40)
    );

    -- 5. Tabela filmes (depende de generos e diretores)
    CREATE TABLE IF NOT EXISTS filmes (
        id_filme INTEGER PRIMARY KEY,
        titulo_filme VARCHAR(80),
        ano_filme INTEGER,
        id_genero INTEGER,
        id_diretor INTEGER,
        CONSTRAINT fk_filmes_generos 
            FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
        CONSTRAINT fk_filmes_diretores 
            FOREIGN KEY (id_diretor) REFERENCES diretores(id_diretor)
    );

    -- 6. Tabela associativa assistidos (N:N entre usuarios e filmes)
    CREATE TABLE IF NOT EXISTS assistidos (
        id_usuario INTEGER,
        id_filme INTEGER,
        PRIMARY KEY (id_usuario, id_filme),
        CONSTRAINT fk_assistidos_usuarios 
            FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
        CONSTRAINT fk_assistidos_filmes 
            FOREIGN KEY (id_filme) REFERENCES filmes(id_filme)
    );

-- 1. Inserção na tabela planos (Tabela Pai)
INSERT INTO planos (id_plano, preco_plano) VALUES
(1, 19.90),
(2, 39.90),
(3, 55.90);

-- 2. Inserção na tabela diretores (Tabela Pai)
INSERT INTO diretores (id_diretor, nome_diretor) VALUES
(1, 'Steven Spielberg'),
(2, 'Christopher Nolan'),
(3, 'Quentin Tarantino'),
(4, 'Greta Gerwig'),
(5, 'Denis Villeneuve');

-- 3. Inserção na tabela generos (Tabela Pai)
INSERT INTO generos (id_genero, nome_genero) VALUES
(1, 'Ação'),
(2, 'Ficção Científica'),
(3, 'Drama'),
(4, 'Comédia'),
(5, 'Aventura');

-- 4. Inserção na tabela usuarios (Depende de planos)
INSERT INTO usuarios (id_usuario, email_usuario, id_plano) VALUES
(1, 'carlos.silva@email.com', 1),
(2, 'ana.souza@email.com', 2),
(3, 'marcelo.oliveira@email.com', 3),
(4, 'juliana.santos@email.com', 2),
(5, 'fernando.costa@email.com', 1),
(6, 'beatriz.lima@email.com', 3),
(7, 'lucas.almeida@email.com', 2),
(8, 'mariana.rodriguez@email.com', 1);

-- 5. Inserção na tabela filmes (Depende de generos e diretores)
INSERT INTO filmes (id_filme, titulo_filme, ano_filme, id_genero, id_diretor) VALUES
(1, 'A Origem', 2010, 2, 2),
(2, 'Jurassic Park', 1993, 5, 1),
(3, 'Pulp Fiction', 1994, 3, 3),
(4, 'Interstellar', 2014, 2, 2),
(5, 'Duna', 2021, 2, 5),
(6, 'Barbie', 2023, 4, 4),
(7, 'O Resgate do Soldado Ryan', 1998, 1, 1),
(8, 'Oppenheimer', 2023, 3, 2);

-- 6. Inserção na tabela associativa assistidos (Depende de usuarios e filmes - sem pares duplicados)
INSERT INTO assistidos (id_usuario, id_filme) VALUES
(1, 1),
(1, 2),
(1, 4),
(2, 2),
(2, 3),
(2, 6),
(3, 1),
(3, 4),
(3, 5),
(3, 8),
(4, 3),
(4, 6),
(5, 2),
(5, 7),
(6, 1),
(6, 5),
(6, 8),
(7, 4),
(7, 5),
(8, 6),
(8, 7);