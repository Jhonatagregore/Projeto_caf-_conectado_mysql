CREATE DATABASE IF NOT EXISTS café;
USE cafe_conectado;

-- 1. Tabela CLIENTE
CREATE TABLE CLIENTE (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL, -- Formato XXX.XXX.XXX-XX
    email VARCHAR(100) UNIQUE NOT NULL,
    cep VARCHAR(9), -- Formato XXXXX-XXX
    rua VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    ponto_de_referencia VARCHAR(255)
);

-- 2. Tabela PEDIDO
CREATE TABLE PEDIDO (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_hora_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    tipo_modo ENUM('ENTREGA', 'RETIRADA') NOT NULL, -- Para diferenciar o modo do pedido
    
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(cliente_id)
);

-- 3. Tabela ENTREGA
CREATE TABLE ENTREGA (
    pedido_id INT PRIMARY KEY, -- Chave primária e chave estrangeira para PEDIDO
    endereco_entrega VARCHAR(255) NOT NULL, -- Pode ser o endereço completo ou uma referência ao endereço do cliente
    
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id)
);

-- 4. Tabela RETIRADA
CREATE TABLE RETIRADA (
    pedido_id INT PRIMARY KEY, -- Chave primária e chave estrangeira para PEDIDO
    
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id)
);

-- 5. Tabela PAGAMENTO
CREATE TABLE PAGAMENTO (
    pagamento_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT UNIQUE NOT NULL, -- Cada pedido tem um único pagamento
    metodo_pagamento ENUM('DEBITO', 'CREDITO', 'PIX', 'VR_OU_OUTRO') NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id)
);

-- 6. Tabela STATUS
-- Tabela de Status (para padronizar os nomes dos status)
CREATE TABLE STATUS (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) UNIQUE NOT NULL
);

-- 7. Tabela PEDIDO_STATUS_HISTORICO
-- Rastreia o histórico de mudanças de status do pedido
CREATE TABLE PEDIDO_STATUS_HISTORICO (
    historico_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    status_id INT NOT NULL,
    data_hora_mudanca DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id),
    FOREIGN KEY (status_id) REFERENCES STATUS(status_id)
);

-- 8. Tabela PRODUTO
CREATE TABLE PRODUTO (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50)
);

-- 9. Tabela ITEM_PEDIDO
-- Relacionamento N:M entre PEDIDO e PRODUTO
CREATE TABLE ITEM_PEDIDO (
    item_pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    
    FOREIGN KEY (pedido_id) REFERENCES PEDIDO(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES PRODUTO(produto_id),
    UNIQUE (pedido_id, produto_id) -- Garante que um produto só aparece uma vez por pedido
);

INSERT INTO STATUS (descricao) VALUES
('PRONTO PARA RETIRAR'),
('SAIU PARA A ENTREGA'),
('EM PREPARO'),
('ESPERA OU ENTREGA');

-- Inserção de Produtos
INSERT INTO PRODUTO (nome, descricao, preco, categoria) VALUES
-- CAFÉS TRADICIONAIS
('Café Expresso', 'Sabor intenso, feito com grãos selecionados.', 6.00, 'CAFÉS TRADICIONAIS'),
('Café Americano', 'Expresso suavizado com água quente.', 7.00, 'CAFÉS TRADICIONAIS'),
('Café Coado', 'Clássico, leve e aromático.', 5.00, 'CAFÉS TRADICIONAIS'),

-- CAFÉS COM LEITE
('Cappuccino', 'Mistura cremosa de café, leite vaporizado e espuma.', 12.00, 'CAFÉS COM LEITE'),
('Latte', 'Expresso com bastante leite vaporizado, suave.', 11.00, 'CAFÉS COM LEITE'),
('Mocha', 'Latte com calda de chocolate e chantilly.', 14.00, 'CAFÉS COM LEITE'),

-- CAFÉS ESPECIAIS
('Caramelo Macchiato', 'Expresso com baunilha, leite vaporizado e calda de caramelo.', 15.00, 'CAFÉS ESPECIAIS'),
('Affogato', 'Bola de sorvete de creme coberta com expresso quente.', 16.00, 'CAFÉS ESPECIAIS'),
('Irish Coffee (sem álcool)', 'Café quente com creme doce e toque aromático.', 15.00, 'CAFÉS ESPECIAIS'),

-- GELADOS
('Iced Coffee', 'Café gelado com cubos de gelo.', 10.00, 'GELADOS'),
('Frappuccino', 'Café batido com leite, gelo e creme.', 16.00, 'GELADOS'),
('Iced Mocha', 'Café gelado com chocolate e leite.', 17.00, 'GELADOS');

