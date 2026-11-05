-- Criando tabela de autores
CREATE TABLE autores (
id_autor SERIAL PRIMARY KEY,
nome_autor VARCHAR(80) NOT NULL,

);

-- Criando tabela de livros
CREATE TABLE livros (
id_livro SERIAL,
nome_livro VARCHAR(30),
ano_livro INTEGER,
id_autor INTEGER NOT NULL,
id_editora INTEGER NOT NULL,
CONSTRAINT pk_livros
PRIMARY KEY(id_livro),
CONSTRAINT check_ano_livro
CHECK(ano_livro BETWEEN 1900 AND 2026),
CONSTRAINT fk_id_autor
FOREIGN KEY(id_autor) REFERENCES autores(id_autor),
CONSTRAINT fk_editora_livro
FOREIGN KEY(id_editora) REFERENCES editoras(id_editora)
);

-- Inserir a coluna isbn
ALTER TABLE livros ADD COLUMN isbn CHAR(8)

-- Alterando o nome para codigo_isbn
ALTER TABLE livros RENAME COLUMN isbn TO  codigo_isbn

-- Eliminando coluna desnecessária
ALTER TABLE livros DROP COLUMN codigo_isbn
