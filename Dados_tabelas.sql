INSERT INTO CLIENTE (nome, cpf, email, cep, rua, bairro, cidade, ponto_de_referencia) VALUES
('Jhonata', '111.222.333.44', 'jhonata.123@gmail.com', '01001-000', 'Rua algum lugar','centro', 'São paulo', 'proxima rua'),
('talita', '113.224.335.45', 'talita.123@gmail.com', '01001-030', 'Rua proximo lugar','centro', 'São paulo', 'proxima rua'),
('gabriel', '116.227.338.46', 'gabriel.123@gmail.com', '01001-040', 'Rua depois do lugar','centro', 'São paulo', 'proxima rua'),
('julia', '112.223.334.47', 'julia.123@gmail.com', '01001-050', 'Rua antes do lugar','centro', 'São paulo', 'proxima rua');

INSERT INTO PEDIDO (cliente_id, data_hora_pedido, valor_total, tipo_modo)VALUE
('1', '2025-11-25 10:00:00', 24.00, 'ENTREGA');
INSERT INTO PEDIDO (cliente_id, data_hora_pedido, valor_total, tipo_modo) VALUES
(2, '2025-11-25 09:50:00', 34.00, 'RETIRADA');
INSERT INTO PEDIDO (cliente_id, data_hora_pedido, valor_total, tipo_modo) VALUES
(3, '2025-11-26 09:00:00', 15.00, 'ENTREGA');
INSERT INTO PEDIDO (cliente_id, data_hora_pedido, valor_total, tipo_modo) VALUES
(4, '2025-11-26 11:00:00', 24.00, 'RETIRADA');

INSERT INTO ITEM_PEDIDO (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 2, 6.00), -- Café Expresso
(1, 4, 1, 12.00); -- Cappuccino

INSERT INTO ITEM_PEDIDO (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(2, 7, 1, 15.00), -- Caramelo Macchiato
(2, 12, 1, 17.00); -- Iced Mocha

INSERT INTO ITEM_PEDIDO (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(3, 3, 3, 5.00); -- Café Coado

INSERT INTO ITEM_PEDIDO (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(4, 6, 1, 14.00), -- Mocha
(4, 10, 1, 10.00); -- Iced Coffee

INSERT INTO PAGAMENTO (pedido_id, metodo_pagamento, valor_pago) VALUES
(1, 'PIX', 24.00),
(2, 'CREDITO', 32.00),
(3, 'DEBITO', 15.00),
(4, 'VR_OU_OUTRO', 24.00);

INSERT INTO ENTREGA (pedido_id, endereco_entrega) VALUES
(1,  '01001-000, Rua algum lugar centro, São paulo, proxima rua');

INSERT INTO ENTREGA (pedido_id, endereco_entrega) VALUES
(2,  '01001-030, Rua proximo lugar centro, São paulo, proxima rua');

INSERT INTO ENTREGA (pedido_id, endereco_entrega) VALUES
(3,  '01001-040, Rua depois do lugar centro, São paulo, proxima rua');

INSERT INTO ENTREGA (pedido_id, endereco_entrega) VALUES
(4,);

INSERT INTO PEDIDO_STATUS_HISTORICO (pedido_id, status_id, data_hora_mudanca) VALUES
(1, 3, '2025-11-25 10:00:00'), -- EM PREPARO
(1, 2, '2025-11-25 10:15:00'); -- SAIU PARA A ENTREGA

INSERT INTO PEDIDO_STATUS_HISTORICO (pedido_id, status_id, data_hora_mudanca) VALUES
(2, 3, '2025-11-25 10:30:00'), -- EM PREPARO
(2, 1, '2025-11-25 10:45:00'); -- PRONTO PARA RETIRAR

INSERT INTO PEDIDO_STATUS_HISTORICO (pedido_id, status_id, data_hora_mudanca) VALUES
(3, 3, '2025-11-26 09:00:00'), -- EM PREPARO
(3, 4, '2025-11-26 09:10:00'); -- ESPERA OU ENTREGA

INSERT INTO PEDIDO_STATUS_HISTORICO (pedido_id, status_id, data_hora_mudanca) VALUES
(4, 3, '2025-11-26 11:00:00'), -- EM PREPARO
(4, 1, '2025-11-26 11:20:00'); -- PRONTO PARA RETIRAR



SELECT
    P.pedido_id,
    C.nome AS nome_cliente,
    P.valor_total,
    P.tipo_modo,
    P.data_hora_pedido
FROM
    PEDIDO P
JOIN
    CLIENTE C ON P.cliente_id = C.cliente_id
ORDER BY
    P.data_hora_pedido DESC;

-- 3.2. CONSULTA COM ORDER BY e LIMIT: Encontrar os 3 produtos mais caros.
SELECT
    nome,
    preco,
    categoria
FROM
    PRODUTO
ORDER BY
    preco DESC
LIMIT 3;

-- 3.3. CONSULTA COM JOIN e WHERE: Listar todos os itens pedidos por um cliente específico (Ana Silva).
SELECT
    C.nome AS cliente,
    P.nome AS produto,
    IP.quantidade,
    IP.preco_unitario
FROM
    CLIENTE C
JOIN
    PEDIDO PE ON C.cliente_id = PE.cliente_id
JOIN
    ITEM_PEDIDO IP ON PE.pedido_id = IP.pedido_id
JOIN
    PRODUTO P ON IP.produto_id = P.produto_id
WHERE
    C.nome = 'jhonata';

-- 3.4. CONSULTA COM GROUP BY e FUNÇÃO DE AGREGAÇÃO (SUM): Calcular o valor total vendido por categoria de produto.
SELECT
    PR.categoria,
    SUM(IP.quantidade * IP.preco_unitario) AS total_vendido
FROM
    ITEM_PEDIDO IP
JOIN
    PRODUTO PR ON IP.produto_id = PR.produto_id
GROUP BY
    PR.categoria
ORDER BY
    total_vendido DESC;

-- 3.5. CONSULTA COM SUBQUERY e WHERE: Encontrar clientes que fizeram pedidos do tipo 'ENTREGA'.
SELECT
    nome,
    email
FROM
    CLIENTE
WHERE
    cliente_id IN (
        SELECT DISTINCT
            cliente_id
        FROM
            PEDIDO
        WHERE
            tipo_modo = 'ENTREGA'
    );