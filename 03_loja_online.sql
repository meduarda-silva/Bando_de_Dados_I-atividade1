-- 1. Criação da tabela clientes
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY, -- Chave primária (identificador único do cliente)
    nome VARCHAR(80)                -- Nome do cliente (texto até 80 caracteres)
);

-- 2. criando tabela de pedidos
CREATE TABLE pedidos (
 id_pedido INTEGER PRIMARY KEY,
 data_pedido DATE,
 id_cliente INTEGER,
 CONSTRAINT fk_id_client FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 3. Criar a tabela categorias
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INTEGER PRIMARY KEY,
    nome VARCHAR(40)
);

-- 4. Criar a tabela produtos (depende de categorias)
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INTEGER PRIMARY KEY,
    nome VARCHAR(80),
    preco DECIMAL(8,2),
    id_categoria INTEGER,
    CONSTRAINT fk_produtos_categorias 
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- 5. Criar a tabela "pedidos" (depende de clientes)
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INTEGER PRIMARY KEY,
    data_pedido DATE,
    id_cliente INTEGER,
    CONSTRAINT fk_pedidos_clientes 
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 6. Criar a tabela associativa "item_pedido" (depende de pedidos e produtos)
CREATE TABLE IF NOT EXISTS item_pedido (
    id_pedido INTEGER,
    id_produto INTEGER,
    quantidade INTEGER,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_item_pedido_pedidos 
        FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT fk_item_pedido_produtos 
        FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)

);

-- Alterar colunas na tabela produtos
ALTER TABLE produtos RENAME COLUMN nome TO nome_produto;
ALTER TABLE produtos RENAME COLUMN preco TO preco_produto;

-- Alterar coluna na tabela categorias
ALTER TABLE categorias RENAME COLUMN nome TO nome_categoria;

-- Alterar coluna na tabela item_pedido (caso queira ajustar a quantidade)
ALTER TABLE item_pedido RENAME COLUMN quantidade TO quantidade_item;

-- 1. Inserção na tabela clientes (Tabela Pai)
INSERT INTO clientes (id_cliente, nome_cliente) VALUES
(1, 'Ana Silva'),
(2, 'Carlos Eduardo Oliveira'),
(3, 'Mariana Souza'),
(4, 'Fernando Rocha'),
(5, 'Beatriz Lima'),
(6, 'Lucas Mendes'),
(7, 'Juliana Ferreira'),
(8, 'Gabriel Alves'),
(9, 'Camila Ribeiro'),
(10, 'Rafael Costa');

-- 2. Inserção na tabela categorias (Tabela Pai)
INSERT INTO categorias (id_categoria, nome_categoria) VALUES
(1, 'Eletrônicos'),
(2, 'Informática'),
(3, 'Móveis'),
(4, 'Livros'),
(5, 'Eletrodomésticos');

-- 3. Inserção na tabela produtos (Depende de categorias)
INSERT INTO produtos (id_produto, nome_produto, preco_produto, id_categoria) VALUES
(1, 'Smartphone Galaxy S23', 4299.90, 1),
(2, 'Fone de Ouvido Bluetooth', 249.90, 1),
(3, 'Notebook Dell Inspiron', 3899.00, 2),
(4, 'Mouse Sem Fio Ergonômico', 129.50, 2),
(5, 'Teclado Mecânico RGB', 299.00, 2),
(6, 'Cadeira de Escritório Ergonômica', 850.00, 3),
(7, 'Mesa para Computador 120cm', 420.00, 3),
(8, 'Clean Code - Código Limpo', 89.90, 4),
(9, 'O Design do Dia a Dia', 65.00, 4),
(10, 'Cafeteira Expressa Automática', 599.90, 5);

-- 4. Inserção na tabela pedidos (Depende de clientes)
INSERT INTO pedidos (id_pedido, data_pedido, id_cliente) VALUES
(1, '2026-01-10', 1),
(2, '2026-01-15', 2),
(3, '2026-01-20', 3),
(4, '2026-02-02', 1),
(5, '2026-02-10', 4),
(6, '2026-02-14', 5),
(7, '2026-03-01', 6),
(8, '2026-03-05', 7);

-- 5. Inserção na tabela associativa item_pedido (Depende de pedidos e produtos)
INSERT INTO item_pedido (id_pedido, id_produto, quantidade_item) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1),
(2, 5, 1),
(3, 6, 1),
(3, 7, 1),
(4, 8, 2),
(4, 9, 1),
(5, 10, 1),
(6, 2, 1),
(6, 5, 1),
(7, 3, 1),
(7, 6, 1),
(8, 8, 1),
(8, 10, 1);