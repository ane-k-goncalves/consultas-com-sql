    MODELAGEM 1
    
CREATE TABLE departamento (codDepartamento INT AUTO_INCREMENT PRIMARY KEY,nome VARCHAR(40) NOT NULL UNIQUE, descricaoFuncional VARCHAR(80), localizacao TEXT);

CREATE TABLE estado (siglaEstado CHAR(2), nome VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE cidade (codCidade INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE, siglaEstado CHAR(2) NOT NULL);

CREATE TABLE vendedor (codVendedor INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(60) NOT NULL, dataNascimento DATE, endereco VARCHAR(60), cep CHAR(8), telefone VARCHAR(20), codCidade INTEGER, dataContratacao DATE DEFAULT (CURRENT_DATE), copDepartamento INTEGER );

CREATE TABLE cliente (codCliente INT AUTO_INCREMENT PRIMARY KEY, endereco VARCHAR(60), codCidade INT NOT NULL, telefone VARCHAR(20), tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'J')), dataCadastro DATE DEFAULT (CURRENT_DATE), cep CHAR(8) );

CREATE TABLE clienteFisico (codCliente INT, nome VARCHAR(50), dataNascimento DATE, cpf CHAR(11) NOT NULL UNIQUE, rg CHAR(8) );

CREATE TABLE clienteJuridico (codCliente INT, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE );

CREATE TABLE classe (codClasse INT AUTO_INCREMENT PRIMARY KEY, sigla VARCHAR(12), nome VARCHAR(40)NOT NULL, descricao VARCHAR(80));

CREATE TABLE produto (codProduto INT AUTO_INCREMENT PRIMARY KEY, descricao VARCHAR(40) NOT NULL, unidadeMedida CHAR(2), embalagem VARCHAR(15) DEFAULT 'Fardo', codClass INT, precoVenda DECIMAL(14,2), estoqueMinimo DECIMAL(14,2));

CREATE TABLE produtoLote (codProduto INT, numeroLote INT, quantidadeAdquirida DECIMAL(14,2), quantidadeVendida DECIMAL(14,2), precoCusto DECIMAL(14,2), dataValidade DATE);

CREATE TABLE venda (codVenda INT, codCliente INT, codVendedor INT, dataVenda DATE DEFAULT (CURRENT_DATE), enderecoEntrega VARCHAR(60), status VARCHAR(30));

CREATE TABLE itemVenda (codVenda INT, codProduto INT, numeroLote INT, quantidade DECIMAL(14,2) NOT NULL CHECK (quantidade > 0));

CREATE TABLE fornecedor (codFornecedor INT, nomeFantasia VARCHAR(80) UNIQUE, razaoSocial VARCHAR(80) NOT NULL UNIQUE, ie VARCHAR(20) NOT NULL UNIQUE, cgc VARCHAR(20) NOT NULL UNIQUE, endereco VARCHAR(60), telefone VARCHAR(20), codCidade INT);

CREATE TABLE pedido (codPedido INT AUTO_INCREMENT PRIMARY KEY, dataRealizacao DATE DEFAULT(CURRENT_DATE), dataEntrega DATE, codFornecedor INT, valor DECIMAL(20,2));

CREATE TABLE itemPedido (codPedido INT, codProduto INT, quantidade DECIMAL(14,2) NOT NULL CHECK(quantidade > 0));



