-- select idCategoria, sum(valor) 
-- from produtos 
-- group by idCategoria 
-- having sum(valor) > 50

select numero, 
status, 
valorTotal,
case
when valorTotal <200 then 'Barato' 
when valorTotal >=250 and
valorTotal <= 300 then 'Médio' 
else 'Caro'
end as situacao
from pedidos
