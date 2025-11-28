Projeto de Manipulação de Dados SQL (DML) - Café Conectado
Este repositório contém o script SQL completo para a implementação e manipulação de dados no banco de dados relacional cafe_conectado, conforme o modelo lógico previamente definido. O projeto foca na aplicação da Linguagem de Manipulação de Dados (DML), utilizando comandos INSERT, SELECT, UPDATE e DELETE, e integrando práticas de versionamento de código.

Arquivo Principal
O projeto é centralizado no arquivo Script_principal.sql, que combina todas as etapas necessárias para criar, popular e manipular o banco de dados em uma única execução.

Conteúdo do Script 
O script segue a ordem lógica de execução:

1	DDL (Data Definition Language): Cria o banco de dados cafe_conectado e todas as tabelas (CLIENTE, PEDIDO, PRODUTO, etc.).
2	DML - INSERT: Insere dados de exemplo em todas as tabelas, garantindo a coerência e a integridade referencial.
3	DML - SELECT: Contém 5 consultas complexas para demonstração, utilizando JOIN, WHERE, GROUP BY, ORDER BY e SUBQUERY.
4	DML - UPDATE e DELETE: Demonstra a manipulação de dados com comandos de atualização e exclusão com condições, respeitando as restrições de chaves estrangeiras.

🛠️ Instruções de Execução
O script foi desenvolvido para ser executado em um ambiente de banco de dados MySQL (ou compatível, como MariaDB).

Pré-requisitos
•	Servidor MySQL/MariaDB instalado e em execução.
•	Ferramenta Cliente (MySQL Workbench, DBeaver, etc.) para conectar ao servidor.

Passo a Passo
5	Obtenha o Arquivo: Baixe o arquivo cafe_conectado_full_script.sql.
6	Abra no Cliente: Abra o arquivo no editor de consultas da sua ferramenta de banco de dados.
7	Execute: Execute o script completo.

O script criará o banco de dados, populará as tabelas e, em seguida, executará os comandos de UPDATE e DELETE para demonstrar a manipulação de dados.



Demonstração DML (Comandos Chave)
O script principal é script_principal.sql agora os outros scripts sao de atualização e inserção de dados mas todos atendem integralmente aos requisitos de entrega:

1. Comandos de INSERT (Povoamento)
O script insere dados em todas as tabelas, incluindo clientes, produtos, pedidos, itens de pedido, pagamentos e histórico de status.

Exemplo de INSERT:

INSERT INTO PRODUTO (nome, descricao, preco, categoria) VALUES
('Café Expresso', 'Sabor intenso, feito com grãos selecionados.', 6.00, 'CAFÉS TRADICIONAIS'),
('Cappuccino', 'Mistura cremosa de café, leite vaporizado e espuma.', 12.00, 'CAFÉS COM LEITE');

2. Consultas (SELECT)
O script inclui 5 consultas, conforme solicitado, para demonstrar o uso de comandos avançados:

Consulta	Descrição	Comandos Utilizados
Consulta 1	Listar pedidos com nome do cliente.	SELECT, JOIN, ORDER BY
Consulta 2	Encontrar os 3 produtos mais caros.	SELECT, ORDER BY, LIMIT
Consulta 3	Listar itens pedidos por um cliente específico.	SELECT, Múltiplos JOIN, WHERE
Consulta 4	Calcular o valor total vendido por categoria.	SELECT, JOIN, SUM, GROUP BY
Consulta 5	Encontrar clientes que fizeram pedidos de 'ENTREGA'.	SELECT, WHERE, SUBQUERY
3. Comandos de UPDATE e DELETE (Com Condições)
O script demonstra a manipulação de dados com foco na integridade.

UPDATE (3 Exemplos)
8	Atualização do e-mail de um cliente.
9	Aumento de 10% no preço de produtos de uma categoria.
10	Correção do valor total de um pedido.

DELETE (Exclusão em Cascata)
O script demonstra a exclusão completa de um pedido e do cliente associado, respeitando a ordem de dependência das chaves estrangeiras:

-- Exclusão do pagamento, itens, retirada, histórico e, por fim, o pedido e o cliente.
DELETE FROM PAGAMENTO WHERE pedido_id = 4;
DELETE FROM ITEM_PEDIDO WHERE pedido_id = 4;
-- ... (outros comandos de DELETE)
DELETE FROM CLIENTE WHERE cliente_id = 4;
