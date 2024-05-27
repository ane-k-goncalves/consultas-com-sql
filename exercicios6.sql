TIPOS DE JUNÇÃO DE TABELAS

1)Apresentar os pedidos realizados no ano de 2014. Campos: código do pedido, data de realização, data de entrega e nome fantasia do fornecedor. Usar junção natural.

SELECT pedido.codPedido, pedido.dataRealizacao, pedido.dataEntrega, fornecedor.nomeFantasia FROM pedido NATURAL INNER JOIN fornecedor WHERE YEAR(pedido.dataRealizacao) = 2014;

2)Listar os vendedores da cidade de ‘Apucarana’. Campos: nome do vendedor, data de nascimento, nome da cidade. Usar equi-junção.

SELECT vendedor.nome, vendedor.dataNascimento, cidade.nome FROM vendedor, cidade WHERE vendedor.codCidade = cidade.codCidade AND cidade.nome = 'Apucarana';

3)Listar as informações das vendas do produto ‘Cal’. Campos: código da venda, data da venda, nome do vendedor, número do lote, descrição do produto. Usar junção natural.

SELECT venda.codVenda, venda.dataVenda, vendedor.nome, produtoLote.numeroLote, produto.descricao FROM venda NATURAL INNER JOIN itemVenda NATURAL INNER JOIN vendedor NATURAL INNER JOIN produtoLote NATURAL INNER JOIN produto WHERE produto.descricao = 'Cal';

4)Listar as informações dos produtos da classe ‘Acabamentos’. Campos: sigla da classe, nome da classe, código do produto, descrição, estoque mínimo.

SELECT classe.sigla, classe.nome AS classe_nome, produto.codProduto, produto.descricao, produto.estoqueMinimo FROM produto JOIN classe ON produto.codClasse = classe.codClasse WHERE classe.nome = 'Acabamentos';

5)Listar as informações dos pedidos do fornecedor ‘Incepa’. Campos: Nome Fantasia do fornecedor, código do pedido, data de realização, data da entrega.

SELECT fornecedor.nomeFantasia, pedido.codPedido, pedido.dataRealizacao, pedido.dataEntrega FROM fornecedor JOIN pedido ON fornecedor.codFornecedor = pedido.codFornecedor WHERE fornecedor.nomeFantasia = 'Incepa';

6)Apresentar todos os produtos, e quando existirem, as vendas relativas ao produto. Campos: código do produto, descrição do produto, código da venda.  USAR LEFT JOIN

SELECT produto.codProduto, produto.descricao, itemVenda.codVenda FROM produto LEFT JOIN itemVenda ON produto.codProduto = itemVenda.codProduto; 

7)Apresentar todos os fornecedores cadastrados, e quando existirem, os seus pedidos. Campos: nome fantasia do fornecedor, código do pedido, data de entrega do pedido. USAR LEFT JOIN 

SELECT fornecedor.nomeFantasia, pedido.codPedido, pedido.dataEntrega FROM fornecedor LEFT JOIN pedido ON fornecedor.codFornecedor = pedido.codFornecedor;

8)Apresentar todos os departamentos, e seus vendedores. Apresentar também os departamentos que não possuem vendedores. Campos: nome do departamento, localização, nome do funcionário, data de nascimento. USAR RIGHT JOIN

SELECT departamento.nome, departamento.localizacao, vendedor.nome, vendedor.dataNascimento FROM vendedor RIGHT JOIN departamento ON departamento.codDepartamento = vendedor.codDepartamento;


