-- 1. Criar uma trigger para atualizar o estoque ao adicionar um item ao carrinho

DELIMITER //
CREATE TRIGGER atualizaEstoque
AFTER INSERT ON carrinhoItens
FOR EACH ROW  
BEGIN
	
    UPDATE produtos 
    SET quantidadeEstoque = quantidadeEstoque - NEW.quantidade
    WHERE idProduto = NEW.idProduto;
    
END //
DELIMITER ;
-- SELECT * FROM produtos WHERE idProduto = "PRD001";
-- SELECT * FROM carrinhoItens WHERE idProduto = "PRD001"; 

INSERT INTO carrinhoItens(idCarrinhoCompra, idProduto, quantidade, valor)
VALUES ("CC004", "PRD001", 4, 100);

-- 2. Criar uma trigger para restaurar o estoque ao remover um item do carrinho

DELIMITER //
CREATE TRIGGER atualizaEstoqueDeletaItem
AFTER DELETE ON carrinhoItens
FOR EACH ROW
BEGIN

	UPDATE produtos
    SET quantidadeEstoque = quantidadeEstoque + OLD.quantidade
    WHERE idProduto = OLD.idProduto;

END //
DELIMITER ;
SELECT * FROM carrinhoItens WHERE idProduto = "PRD001";
DELETE FROM carrinhoItens WHERE idCarrinhoCompra = "CC004"
	AND idProduto = "PRD001" AND quantidade = 4
    
    
-- 3. Criar uma trigger para atualizar o status do pedido ao ser pago

DELIMITER //
CREATE TRIGGER atualizaStatusPedido
AFTER INSERT ON pagamentos
FOR EACH ROW
BEGIN
UPDATE pedidos
SET status = "Pago"
WHERE idPedido = NEW.idPedido;
END //
DELIMITER ;

SELECT * FROM pedidos WHERE idPedido = "P002";

INSERT INTO pagamentos(idPagamento, valor, idMeioPagamento, idPedido)
VALUES("PG002", 10, "MP001", "P002")

-- 4. Criar uma trigger para calcular o valor total de um pedido ao inserir um item no pedido

DELIMITER //
CREATE TRIGGER atualizaTotalPedido
AFTER INSERT ON pedidoItens
FOR EACH ROW
BEGIN

	UPDATE pedidos
    SET valorTotal = (SELECT SUM(quantidade * valor) 
    FROM pedidoItens 
    WHERE idPedido = NEW.idPedido)
	WHERE idPedido = NEW.idPedido;
    
END //
DELIMITER ;
INSERT INTO pedidoItens
(idPedido, idVendedor, idCliente, idProduto, quantidade, valor)
VALUES ("P002", "V02", "C001", "PRD003", 10, 100);
SELECT * FROM pedidos WHERE idPedido = "P002";