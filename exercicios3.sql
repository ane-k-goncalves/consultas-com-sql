    MODELAGEM 2

CREATE TABLE departamento (codDepartamento INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE, descricaoFuncional VARCHAR(80), localizacao TEXT); 

CREATE TABLE estado (siglaEstado CHAR(2) PRIMARY KEY, nome VARCHAR(30) NOT NULL UNIQUE); 

CREATE TABLE cidade ( codCidade INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE, siglaEstado CHAR(2) NOT NULL, FOREIGN KEY (siglaEstado) REFERENCES estado(siglaEstado) ); 

CREATE TABLE vendedor (codVendedor INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(60) NOT NULL, dataNascimento DATE, endereco VARCHAR(60), cep CHAR(8), telefone VARCHAR(20), codCidade INT, dataContratacao DATE DEFAULT (CURDATE()), codDepartamento INT, FOREIGN KEY (codDepartamento) REFERENCES departamento(codDepartamento), FOREIGN KEY (codCidade) REFERENCES cidade(codCidade)); 

CREATE TABLE cliente (codCliente INT AUTO_INCREMENT PRIMARY KEY, endereco VARCHAR(60), codCidade INT NOT NULL, telefone VARCHAR(20), tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'J')), dataCadastro DATE DEFAULT (CURRENT_DATE), cep CHAR(8), FOREIGN KEY (codCidade) REFERENCES cidade(codCidade) ); 

CREATE TABLE clienteFisico (codCliente INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50), dataNascimento DATE, cpf CHAR(11) NOT NULL UNIQUE, rg CHAR(8), FOREIGN KEY (codCliente) REFERENCES cliente(codCliente)); 

CREATE TABLE clienteJuridico (codCliente INT AUTO_INCREMENT PRIMARY KEY, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE, FOREIGN KEY (codCliente) REFERENCES cliente(codCliente) ); 

CREATE TABLE classe (codClasse INT AUTO_INCREMENT PRIMARY KEY, sigla VARCHAR(12), nome VARCHAR(40)NOT NULL, descricao VARCHAR(80));

CREATE TABLE produto (codProduto INT AUTO_INCREMENT PRIMARY KEY, descricao VARCHAR(40) NOT NULL, unidadeMedida CHAR(2), embalagem VARCHAR(15) DEFAULT 'Fardo', codClasse INT, precoVenda DECIMAL(14,2), estoqueMinimo DECIMAL(14,2), FOREIGN KEY (codClasse) REFERENCES classe(codClasse)); 

CREATE TABLE produtoLote (codProduto INT AUTO_INCREMENT, numeroLote INT, quantidadeAdquirida DECIMAL(14,2), quantidadeVendida DECIMAL(14,2), precoCusto DECIMAL(14,2), dataValidade DATE, PRIMARY KEY(codProduto, numeroLote), FOREIGN KEY (codProduto) REFERENCES produto(codProduto)); 

CREATE TABLE venda (codVenda INT AUTO_INCREMENT PRIMARY KEY, codCliente INT, codVendedor INT, dataVenda DATE DEFAULT (CURRENT_DATE), enderecoEntrega VARCHAR(60), status VARCHAR(30), FOREIGN KEY (codCliente) REFERENCES cliente(codCliente), FOREIGN KEY (codVendedor) REFERENCES vendedor(codVendedor)); 

CREATE TABLE itemVenda (codVenda INT, codProduto INT, numeroLote INT, quantidade DECIMAL(14,2) NOT NULL CHECK (quantidade > 0), PRIMARY KEY (codVenda, codProduto, numeroLote),FOREIGN KEY (codProduto, numeroLote) REFERENCES produtoLote(codProduto, numeroLote)); 

CREATE TABLE fornecedor (codFornecedor INT AUTO_INCREMENT PRIMARY KEY, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE, endereco VARCHAR(60), telefone VARCHAR(20), codCidade INT, FOREIGN KEY (codCidade) REFERENCES cidade(codCidade)); 

CREATE TABLE pedido (codPedido INT AUTO_INCREMENT PRIMARY KEY, dataRealizacao DATE DEFAULT(CURRENT_DATE), dataEntrega DATE, codFornecedor INT, valor DECIMAL(20,2), FOREIGN KEY (codFornecedor) REFERENCES fornecedor(codFornecedor)); 

CREATE TABLE itemPedido (codPedido INT, codProduto INT, quantidade DECIMAL(14,2) NOT NULL CHECK(quantidade > 0), PRIMARY KEY (codPedido, codProduto), FOREIGN KEY (codPedido) REFERENCES pedido(codPedido),FOREIGN KEY (codProduto) REFERENCES produto(codProduto) ); 

CREATE TABLE contasPagar (codTitulo INT AUTO_INCREMENT PRIMARY KEY, dataVencimento DATE NOT NULL, parcela INT, codPedido INT, valor DECIMAL(20,2), dataPagamento DATE, localPagamento VARCHAR(80), juros DECIMAL(12,2), correcaoMonetaria DECIMAL(12,2), FOREIGN KEY (codPedido) REFERENCES pedido(codPedido)); 

CREATE TABLE contasReceber (codTitulo INT AUTO_INCREMENT PRIMARY KEY, dataVencimento DATE NOT NULL, codVenda INT NOT NULL, parcela INT, valor DECIMAL(20,2), dataPagamento DATE, localPagamento VARCHAR(80), juros DECIMAL(12,2), correcaoMonetaria DECIMAL(12,2), FOREIGN KEY (codVenda) REFERENCES venda(codVenda));