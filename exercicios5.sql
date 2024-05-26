    MODELAGEM 3

CREATE TABLE departamento (codDepartamento INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE, descricaoFuncional VARCHAR(80), localizacao TEXT); 

CREATE TABLE estado (siglaEstado CHAR(2) PRIMARY KEY, nome VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE cidade ( codCidade INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE, siglaEstado CHAR(2) NOT NULL REFERENCES estado(siglaEstado) ON DELETE no action ON UPDATE CASCADE );

CREATE TABLE vendedor (codVendedor INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(60) NOT NULL, dataNascimento DATE, endereco VARCHAR(60), cep CHAR(8), telefone VARCHAR(20), codCidade INT, dataContratacao DATE DEFAULT (CURDATE()), codDepartamento INT, FOREIGN KEY (codDepartamento) REFERENCES departamento(codDepartamento) ON DELETE set null ON UPDATE cascade, FOREIGN KEY (codCidade) REFERENCES cidade(codCidade) ON DELETE cascade ON UPDATE cascade);

CREATE TABLE cliente (codCliente INT AUTO_INCREMENT PRIMARY KEY, endereco VARCHAR(60), codCidade INT NOT NULL, telefone VARCHAR(20), tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'J')), dataCadastro DATE DEFAULT (CURRENT_DATE), cep CHAR(8), CONSTRAINT fk_cliente_cidade FOREIGN KEY (codCidade) REFERENCES cidade(codCidade) ON DELETE no action ON UPDATE cascade );

CREATE TABLE clienteFisico (codCliente INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50), dataNascimento DATE, cpf CHAR(11) NOT NULL UNIQUE, rg CHAR(8), CONSTRAINT fk_clienteFisico_cliente FOREIGN KEY (codCliente) REFERENCES cliente(codCliente) ON DELETE no action ON UPDATE cascade);

CREATE TABLE clienteJuridico (codCliente INT AUTO_INCREMENT PRIMARY KEY, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE, CONSTRAINT fk_clienteJuridico_cliente FOREIGN KEY (codCliente) REFERENCES cliente(codCliente) ON DELETE no action ON UPDATE cascade );

CREATE TABLE classe (codClasse INT AUTO_INCREMENT PRIMARY KEY, sigla VARCHAR(12), nome VARCHAR(40)NOT NULL, descricao VARCHAR(80));

CREATE TABLE produto (codProduto INT AUTO_INCREMENT PRIMARY KEY, descricao VARCHAR(40) NOT NULL, unidadeMedida CHAR(2), embalagem VARCHAR(15) DEFAULT 'Fardo', codClasse INT, precoVenda DECIMAL(14,2), estoqueMinimo DECIMAL(14,2), FOREIGN KEY (codClasse) REFERENCES classe(codClasse) ON DELETE set null ON UPDATE cascade);

CREATE TABLE produtoLote (codProduto INT AUTO_INCREMENT, numeroLote INT, quantidadeAdquirida DECIMAL(14,2), quantidadeVendida DECIMAL(14,2), precoCusto DECIMAL(14,2), dataValidade DATE, PRIMARY KEY(codProduto, numeroLote), FOREIGN KEY (codProduto) REFERENCES produto(codProduto) ON DELETE cascade ON UPDATE cascade);

CREATE TABLE venda (codVenda INT AUTO_INCREMENT PRIMARY KEY, codCliente INT, dataVenda DATE DEFAULT (CURRENT_DATE), enderecoEntrega VARCHAR(60), status VARCHAR(30), codVendedor INT DEFAULT 100, FOREIGN KEY (codCliente) REFERENCES cliente(codCliente) ON DELETE cascade ON UPDATE no ACTION, FOREIGN KEY (codVendedor) REFERENCES vendedor(codVendedor) ON DELETE set default ON UPDATE cascade);

CREATE TABLE itemVenda (codVenda INT, codProduto INT, numeroLote INT, quantidade DECIMAL(14,2) NOT NULL CHECK (quantidade > 0), PRIMARY KEY (codVenda, codProduto, numeroLote),FOREIGN KEY (codVenda) REFERENCES venda(codVenda) ON DELETE cascade ON UPDATE cascade, FOREIGN KEY (codProduto, numeroLote) REFERENCES produtoLote(codProduto, numeroLote) ON DELETE restrict ON UPDATE cascade);

CREATE TABLE fornecedor (codFornecedor INT AUTO_INCREMENT PRIMARY KEY, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE, endereco VARCHAR(60), telefone VARCHAR(20), codCidade INT, FOREIGN KEY (codCidade) REFERENCES cidade(codCidade) ON DELETE no action ON UPDATE cascade);

CREATE TABLE pedido (codPedido INT AUTO_INCREMENT PRIMARY KEY, dataRealizacao DATE DEFAULT(CURRENT_DATE), dataEntrega DATE, codFornecedor INT, valor DECIMAL(20,2), FOREIGN KEY (codFornecedor) REFERENCES fornecedor(codFornecedor) ON DELETE cascade ON UPDATE set null); 

CREATE TABLE itemPedido (codPedido INT, codProduto INT, quantidade DECIMAL(14,2) NOT NULL CHECK(quantidade > 0), PRIMARY KEY (codPedido, codProduto), FOREIGN KEY (codPedido) REFERENCES pedido(codPedido) ON DELETE cascade ON UPDATE cascade, FOREIGN KEY (codProduto) REFERENCES produto(codProduto) );

CREATE TABLE contasPagar (codTitulo INT AUTO_INCREMENT PRIMARY KEY, dataVencimento DATE NOT NULL, parcela INT, codPedido INT, valor DECIMAL(20,2), dataPagamento DATE, localPagamento VARCHAR(80), juros DECIMAL(12,2), correcaoMonetaria DECIMAL(12,2), FOREIGN KEY (codPedido) REFERENCES pedido(codPedido) ON DELETE cascade ON UPDATE cascade); 

CREATE TABLE contasReceber (codTitulo INT AUTO_INCREMENT PRIMARY KEY, dataVencimento DATE NOT NULL, codVenda INT NOT NULL, parcela INT, valor DECIMAL(20,2), dataPagamento DATE, localPagamento VARCHAR(80), juros DECIMAL(12,2), correcaoMonetaria DECIMAL(12,2), FOREIGN KEY (codVenda) REFERENCES venda(codVenda) ON DELETE cascade ON UPDATE cascade);



