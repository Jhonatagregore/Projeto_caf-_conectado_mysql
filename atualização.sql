-- 1. Atualizar o e-mail de um cliente específico (talita- cliente_id 2)
UPDATE CLIENTE
SET email = 'talita.novo@email.com'
WHERE cliente_id = 2;

-- 2. Aumentar o preço de todos os produtos da categoria 'CAFÉS TRADICIONAIS' em 10%
UPDATE PRODUTO
SET preco = preco * 1.10
WHERE categoria = 'CAFÉS TRADICIONAIS';

-- 3. Corrigir o valor total de um pedido (Pedido 3 - pedido_id 3)
UPDATE PEDIDO
SET valor_total = 16.50
WHERE pedido_id = 3;

-- 4.2. COMANDOS DELETE (Mínimo de 3)

-- ATENÇÃO: Para deletar dados de tabelas com chaves estrangeiras, é necessário seguir a ordem de dependência.
-- A exclusão abaixo demonstra a remoção completa do Pedido 4 (pedido_id 4) e do Cliente Daniel Pereira (cliente_id 4).

-- 1. Deletar o pagamento do Pedido 4
DELETE FROM PAGAMENTO
WHERE pedido_id = 4;

-- 2. Deletar todos os itens do Pedido 4
DELETE FROM ITEM_PEDIDO
WHERE pedido_id = 4;

-- 3. Deletar o registro de retirada do Pedido 4
DELETE FROM RETIRADA
WHERE pedido_id = 4;

-- 4. Deletar o histórico de status do Pedido 4
DELETE FROM PEDIDO_STATUS_HISTORICO
WHERE pedido_id = 4;

-- 5. Deletar o pedido completo (Pedido 4)
DELETE FROM PEDIDO
WHERE pedido_id = 4;

-- 6. Deletar o cliente Daniel Pereira (que não possui mais pedidos)
DELETE FROM CLIENTE
WHERE cliente_id = 4;