-- 1
SELECT nome, descricao, valor
FROM produtos WHERE idCategoria IN 
(SELECT idCategoria FROM categorias WHERE nome = 'Eletrônicos');

-- 2 
SELECT idPedido, SUM(quantidade) FROM pedidoitens GROUP BY idPedido;
-- 3
SELECT * FROM clientes AS cli WHERE EXISTS
(SELECT 1 FROM pedidos AS ped 
WHERE ped.idCliente = cli.idCliente);

-- 4
SELECT * FROM vendedores 
WHERE idVendedor 
IN (SELECT idVendedor 
    FROM pedidos 
    WHERE idCliente
    IN (SELECT idCliente
        FROM clientes 
        WHERE email LIKE '%gmail.co';
-- SELECT nome, descricao, valor
-- FROM produtos WHERE idCategoria IN 
-- (SELECT idCategoria FROM categorias WHERE nome = 'Eletrônicos')

-- SELECT idPedido, SUM(quantidade) FROM pedidoitens GROUP BY idPedido

-- SELECT * FROM clientes AS cli WHERE EXISTS
-- (SELECT 1 FROM pedidos AS ped 
-- WHERE ped.idCliente = cli.idCliente)

-- SELECT * FROM vendedores 
-- WHERE idVendedor 
-- IN (SELECT idVendedor 
--     FROM pedidos 
--     WHERE idCliente
--     IN (SELECT idCliente
--         FROM cli


-- Exercicio 7: Group by com Condição de HAVING
SELECT * FROM clientes
JOIN
(
SELECT idCliente,
SUM(valorTotal) AS total FROM pedidos 
GROUP by idCliente
HAVING SUM(valorTotal) > 500
) AS vendas
ON clientes.idCliente = vendas.idCliente;

-- 8 -
SELECT * FROM clientes
JOIN
(
SELECT idCliente, COUNT(idPedido) AS quantidadePedidos FROM PEDIDOS GROUP BY idCliente
) AS relacaoDePedido
ON clientes.idCliente = relacaoDePedido.idCliente;

-- Exercicio 9 Subquery com HAVING: Escreva uma consulta SQL para listar os produtos que foram vendidos em mais de um pedido. Utilize uma subconsulta com HAVING para filtrar esses Produtos
SELECT * FROM produtos
JOIN
(
SELECT idProduto, COUNT(idPedido) AS quantidadePedidos FROM pedidoItens
GROUP BY idProduto HAVING COUNT(idPedido) >= 2
) AS pedidosProduto
ON produtos.idProduto = pedidosProduto.idProduto;

-- 10 Subquery Correlacionado: listar todos os clientes que gastaram mais do que a média geral dos valores do pedido.
SELECT idCliente, SUM(valorTotal) AS total FROM pedidos 
GROUP BY idCliente
HAVING total > (
SELECT AVG(valorTotal) FROM pedidos 
);

-- 2.1 Subquery: Clientes que têm mais de um pedido: Retorne o nome dos clientes que realizaram mais de um pedido
SELECT nome FROM clientes WHERE idCliente IN
(
SELECT idCliente FROM pedidos
GROUP BY idCliente
HAVING COUNT(idPedido) > 1
);

-- 2.2 IN: Pedidos com meios de pagamento específicos: Liste os pedidos que foram pagos com meios de pagamento com os IDs 'MP001' e'MP002'.
SELECT * FROM pedidos WHERE idPedido IN(
SELECT idPedido FROM pagamentos
WHERE idMeioPagamento IN("MP001", "MP002")
);