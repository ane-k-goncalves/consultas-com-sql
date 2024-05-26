    CONSULTAS 2

1)Listar o código, nome, endereço, nome da cidade, nome do estado dos vendedores cadastrados.

SELECT vendedor.codVendedor, vendedor.endereco, vendedor.nome, cidade.nome, estado.nome
FROM vendedor
JOIN cidade
ON vendedor.codCidade = cidade.codCidade
JOIN estado
ON cidade.siglaEstado = estado.siglaEstado;

2)Listar o código da venda, data de venda, nome do vendedor de todas as vendas com status de ‘Despachada’.

SELECT venda.codVenda, venda.dataVenda, vendedor.nome, venda.status 
FROM venda 
JOIN vendedor
ON venda.codVendedor = vendedor.codVendedor
WHERE venda.status = 'Despachada'; 


3)Listar os clientes pessoa física que moram na Rua Marechal Floriano, 56.

SELECT clienteFisico.nome,cliente.endereco
FROM cliente
JOIN clienteFisico 
ON clienteFisico.codCliente = cliente.codCliente 
WHERE cliente.endereco = 'Rua Marechal Floriano, 56'; 

4)Listar todas as informações dos clientes que são pessoas jurídicas.

SELECT *
FROM cliente 
JOIN clienteJuridico 
ON cliente.codCliente = clienteJuridico.codCliente; 

5)Listar o nome fantasia, endereço, telefone, nome da cidade, sigla do estado de todos os clientes jurídicos que foram cadastrados entre 01/01/1999 e 30/06/2003.

SELECT clienteJuridico.nomeFantasia , cliente.endereco, cidade.nome, estado.siglaEstado
FROM cliente 
JOIN clienteJuridico ON cliente.codCliente = clienteJuridico.codCliente 
JOIN cidade ON cidade.codCidade = cliente.codCidade 
JOIN estado ON estado.siglaEstado = cidade.siglaEstado 
WHERE cliente.dataCadastro BETWEEN '1999-01-01' AND '2003-06-30'; 

6)Listar o nome dos vendedores que realizaram vendas para o cliente pessoa jurídica com nome fantasia ‘Gelinski’.

SELECT DISTINCT vendedor.nome 
FROM vendedor JOIN venda ON vendedor.codVendedor = venda.codVendedor 
JOIN cliente ON venda.codCliente = cliente.codCliente 
JOIN clienteJuridico ON clienteJuridico.codCliente = clienteJuridico.codCliente 
WHERE clienteJuridico.nomeFantasia = 'Gelinski'; 

7)Listar o código, o número do lote e o nome dos produtos que estão com a data de validade vencida.

SELECT produto.codProduto, produtoLote.numeroLote, produto.descricao 
FROM produto 
JOIN produtoLote ON produtoLote.codProduto = produto.codProduto 
WHERE produtoLote.dataValidade < CURDATE(); 


8)Listar o nome dos departamentos e o nome dos vendedores neles lotados.

SELECT departamento.nome, vendedor.nome 
FROM departamento 
JOIN vendedor ON departamento.codDepartamento = vendedor.codVendedor; 