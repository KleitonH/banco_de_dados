-- SELECT * FROM pedidos WHERE	idCliente = "C001" AND notafiscal = "NF001"

-- Select 
-- ped.idPedido, 
-- ped.valorTotal, 
-- cl.nome, 
-- cl.email, 
-- ven.nome, 
-- ven.telefone 
-- FROM pedidos AS ped
-- JOIN clientes AS cl on clientes.idCliente = pedidos.idCliente
-- JOIN vendedores AS ven ON pedidos.idVendedor = vendedores.idVendedor
-- WHERE pedidos.status = "Enviado"

select * from clientes 
where idCLiente in (select distinct idCliente from pedidos);

