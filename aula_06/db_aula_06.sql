-- 1 - Crie uma view para listar todos os clientes 
-- e seu respectivos vendedores com quem realizaram compras
CREATE VIEW clientesVendedores AS 
SELECT
	clientes.nome,
    vendedores.nome AS vendedorNome,
    pedidos.valorTotal,
    clientes.idCliente
FROM pedidos
JOIN clientes ON clientes.idCliente = pedidos.idCliente
JOIN vendedores ON vendedores.idVendedor = pedidos.idVendedor;

SELECT * FROM clientesVendedores;

-- 2 - Crie uma view que liste tdos os pedidos feito por um cliente especifico,
--  incluindo o nome do cliente e o valor total do pedido

CREATE VIEW clientesPedidosTotal AS 
SELECT clientes.nome, clientes.idCliente, pedidos.valorTotal FROM pedidos
JOIN clientes ON clientes.idCliente = pedidos.idCliente;

SELECT * FROM clientesPedidosTotal WHERE idCliente = "C001";

-- 3 - Crie  uma view que mostre o total de vendas de cada vendedor
-- quantidade
CREATE VIEW valorTotalVendasVendedor AS
SELECT vendedores.idVendedor, COUNT(pedidos.idPedido) FROM pedidos 
JOIN vendedores ON vendedores.idVendedor = pedidos.idVendedor
GROUP BY vendedores.idVendedores;

SELECT * FROM valorTotalVendasVendedor;

-- valor total
CREATE VIEW valorTotalVendasVendedor AS
SELECT vendedores.idVendedor, SUM(pedidos.valorTotal) FROM pedidos
JOIN vendedores ON pedidos.idVendedor = vendedores.idVendedor
GROUP BY pedidos.idVendedor;

SELECT * FROM valorTotalVendasVendedor;

-- 4 - Crie uma view que consulte os produtos e as categorias

CREATE VIEW view_produtos_por_categorias AS
	SELECT cat.nome AS nomeCategotia, prod.nome AS nomeProduto
    FROM produtos prod
    JOIN categorias cat ON prod.idCategoria = cat.idCategoria;
