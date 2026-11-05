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
-- ============================================================
-- SCRIPT DE CRIAÇÃO E POVOAMENTO DE DADOS (POSTGRESQL)
-- Modelo: Biblioteca (Editoras, Autores e Livros)
-- ============================================================

-- ------------------------------------------------------------
-- 1. CRIAÇÃO DAS TABELAS (Estrutura)
-- ------------------------------------------------------------

-- Tabela de Editoras (Tabela Pai)
CREATE TABLE IF NOT EXISTS editoras (
    id_editora SERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL
);

-- Tabela de Autores (Tabela Pai)
CREATE TABLE IF NOT EXISTS autores (
    id_autor SERIAL PRIMARY KEY,
    nome_autor VARCHAR(80) NOT NULL
);

-- Tabela de Livros (Tabela Filha)
CREATE TABLE IF NOT EXISTS livros (
    id_livro SERIAL,
    nome_livro VARCHAR(30),
    ano_livro INTEGER,
    id_autor INTEGER NOT NULL,
    id_editora INTEGER NOT NULL,
    CONSTRAINT pk_livros PRIMARY KEY(id_livro),
    CONSTRAINT check_ano_livro CHECK(ano_livro BETWEEN 1900 AND 2026),
    CONSTRAINT fk_id_autor FOREIGN KEY(id_autor) REFERENCES autores(id_autor),
    CONSTRAINT fk_editora_livro FOREIGN KEY(id_editora) REFERENCES editoras(id_editora)
);

-- ------------------------------------------------------------
-- 2. INSERÇÃO DOS DADOS (Povoamento)
-- ------------------------------------------------------------

-- Inserindo Editoras (5 registros)
INSERT INTO editoras (nome_editora) VALUES
('Companhia das Letras'),
('Grupo Editorial Record'),
('Editora Intrínseca'),
('Editora Rocco'),
('HarperCollins Brasil');

-- Inserindo Autores (8 registros)
INSERT INTO autores (nome) VALUES
('Machado de Assis'),
('Clarice Lispector'),
('Jorge Amado'),
('Conceição Evaristo'),
('Paulo Coelho'),
('Lygia Fagundes Telles'),
('Ariano Suassuna'),
('Graciliano Ramos');

-- 2. ADICIONANDO COLUNAS FALTANTES NA TABELA 'livros'
-- ------------------------------------------------------------
ALTER TABLE livros 
    ADD COLUMN IF NOT EXISTS ano_livro INTEGER,
    ADD COLUMN IF NOT EXISTS id_autor INTEGER,
    ADD COLUMN IF NOT EXISTS id_editora INTEGER;

-- ------------------------------------------------------------
-- 3. ADICIONANDO CONSTRAINTS E CHAVES ESTRANGEIRAS EM 'livros'
-- ------------------------------------------------------------

-- Validação do intervalo de anos (1900 a 2026)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'check_ano_livro'
    ) THEN
        ALTER TABLE livros ADD CONSTRAINT check_ano_livro CHECK (ano_livro BETWEEN 1900 AND 2026);
    END IF;
END $$;

-- 1. Renomear a coluna na tabela autores de id_utor para id_autor
ALTER TABLE autores RENAME COLUMN id_utor TO id_autor;

-- 2. Criar a chave estrangeira em livros a apontar para autores
ALTER TABLE livros 
    ADD CONSTRAINT fk_id_autor 
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor);

-- 3. Criar a chave estrangeira para a tabela editoras
ALTER TABLE livros 
    ADD CONSTRAINT fk_editora_livro 
    FOREIGN KEY (id_editora) REFERENCES editoras(id_editora);

-- 4. Adicionar a validação do intervalo de anos
ALTER TABLE livros 
    ADD CONSTRAINT check_ano_livro 
    CHECK (ano_livro BETWEEN 1900 AND 2026);

-- 5. Inserir os registos na tabela livros
INSERT INTO livros (titulo_livro, ano_livro, id_autor, id_editora) VALUES
('Dom Casmurro', 1900, 1, 1),
('Memórias Póstumas', 1901, 1, 1),
('A Hora da Estrela', 1977, 2, 2),
('Laços de Família', 1960, 2, 2),
('Capitães da Areia', 1937, 3, 1),
('Gabriela, Cravo e Canela', 1958, 3, 3),
('Olhos D''Água', 2014, 4, 4),
('Ponciá Vicêncio', 2003, 4, 4),
('O Alquimista', 1988, 5, 5),
('As Parceiras', 1971, 6, 2),
('Antes do Baile Verde', 1970, 6, 3),
('Auto da Compadecida', 1955, 7, 2),
('O Auto da Compadecida', 1957, 7, 5),
('Vidas Secas', 1938, 8, 1),
('São Bernardo', 1934, 8, 3);