#CRIAÇÃO DO SCHEMA
CREATE SCHEMA ESTCASOIII;
#CHAMANDO O SCHEMA CRIADO
USE ESTCASOIII;
#CRIANDO AS TABELAS SEM CHAVE ESTRANGEIRA
CREATE TABLE IF NOT EXISTS CLIENTES(
ID_CLIENTE INT PRIMARY KEY,
CNPJ VARCHAR(18) NOT NULL,
RAZAO_SOCIAL VARCHAR (100) NOT NULL,
RAMO_ATV VARCHAR (50) NOT NULL,
DATA_CADASTRAMENTO DATE NOT NULL,
ENDERECOS VARCHAR(50) NOT NULL,
PESSOA_CONTATO TEXT NOT NULL);

CREATE TABLE IF NOT EXISTS EMPREGADOS(
ID_EMPREGADO INT PRIMARY KEY,
NOME VARCHAR(30) NOT NULL, 
Cargo VARCHAR (30) NOT NULL, 
Salario DECIMAL (10,2) NOT NULL, 
Data_Admissao DATE NOT NULL, 
Qualificacoes TEXT NOT NULL, 
Endereco VARCHAR (50) NOT NULL);

CREATE TABLE IF NOT EXISTS EMPRESAS(
ID_EMPRESA INT PRIMARY KEY,
CNPJ VARCHAR(18) NOT NULL,
Razao_Social varchar(100) NOT NULL,
Pessoa_Contato TEXT NOT NULL, 
Endereco VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS FORNECEDORES(
ID_FORNECEDOR INT PRIMARY KEY,
CNPJ_FORNECEDOR VARCHAR(18) NOT NULL,
Razao_Social varchar(100) NOT NULL,
Pessoa_Contato TEXT NOT NULL, 
Endereco VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS TIPOS_DE_ENDEREÇOS(
ID_TIPO INT PRIMARY KEY,
NOME VARCHAR(20) NOT NULL);

#CRIANDO AS TABELAS COM CHAVE ESTRANGEIRA
CREATE TABLE IF NOT EXISTS TELEFONES(
ID_TELEFONE INT PRIMARY KEY,
TELEFONE VARCHAR(20) NOT NULL,
TIPO_ENTIDADE ENUM('CLIENTE', 'EMPREGADO', 'EMPRESA', 'FORNECEDOR') NOT NULL, #DEFININDO A ENTIDADE DO RESPECTIVO TELEFONE
ID_ENTIDADE INT NOT NULL, #DEFININDO UM ID PARA ESSA ENTIDADE
CONSTRAINT FK_CLIENTE FOREIGN KEY (ID_ENTIDADE) REFERENCES CLIENTES(ID_CLIENTE), #CRIANDO A REFERENCIA PARA A CHAVE ESTRANGEIRA ID_ENTIDADE, QUE FARÁ REFERENCIA A CADA TABELA
CONSTRAINT FK_EMPREGADO FOREIGN KEY (ID_ENTIDADE) REFERENCES EMPREGADOS(ID_EMPREGADO),
CONSTRAINT FK_EMPRESA FOREIGN KEY (ID_ENTIDADE) REFERENCES EMPRESAS(ID_EMPRESA),
CONSTRAINT FK_FORNECEDOR FOREIGN KEY (ID_ENTIDADE) REFERENCES FORNECEDORES(ID_FORNECEDOR));

CREATE TABLE IF NOT EXISTS ENDERECOS(
ID_ENDERECO INT PRIMARY KEY,
Numero INT NOT NULL, 
Logradouro VARCHAR(100) NOT NULL, 
Complemento VARCHAR(100) NOT NULL, 
CEP VARCHAR(10) NOT NULL, 
Bairro VARCHAR(50) NOT NULL, 
Cidade VARCHAR(50) NOT NULL, 
Estado VARCHAR(2) NOT NULL,
CLIENTE_ID INT NOT NULL,
CONSTRAINT FK_CLIENTES FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES(ID_CLIENTE));

CREATE TABLE IF NOT EXISTS PRODUTOS(
ID INT PRIMARY KEY,
NOME VARCHAR(50) NOT NULL,
COR VARCHAR(10) NOT NULL,
DIMENSOES DECIMAL(5,2) NOT NULL,
PESO DECIMAL(5,2) NOT NULL,
PRECO DECIMAL(10,2) NOT NULL,
TEMPO_FAB TIME NOT NULL,
DESENHO_PRODUTO BLOB NOT NULL,
HORAS_TRABALHO TIME NOT NULL);

CREATE TABLE IF NOT EXISTS ENCOMENDAS(
ID_ENCOMENDA INT PRIMARY KEY,
DATA_INCLUSAO DATE NOT NULL,
VALOR_TOTAL DECIMAL(10,2),
VALOR_DESCONTO DECIMAL(10,2),
VALOR_LIQUIDO DECIMAL(10,2),
ID_FORMA_PAGAMENTO INT,
QUANT_PARCELAS INT,
PRIMARY KEY(ID_ENCOMENDA,ID_FORMA_PAGAMENTO),
ENC_PROD INT,
CONSTRAINT FK_PRODUTO FOREIGN KEY (ENC_PROD) REFERENCES PRODUTOS(ID_PRODUTO));

CREATE TABLE IF NOT EXISTS TIPOS_COMPONENTE(
ID INT PRIMARY KEY,
NOME VARCHAR(50));

CREATE TABLE IF NOT EXISTS COMPONENTES(
ID INT PRIMARY KEY,
NOME VARCHAR(50) NOT NULL,
QUANTIDADE INT NOT NULL,
PRECO DECIMAL(10,2) NOT NULL,
UNIDADE INT NOT NULL);

CREATE TABLE IF NOT EXISTS MAQUINAS(
ID_MAQUINA INT PRIMARY KEY,
TEMPO_VIDA TIME NOT NULL,
DATA_COMPRA DATE NOT NULL,
DATA_GARANTIA DATE NOT NULL);

CREATE TABLE IF NOT EXISTS RE(
ID INT PRIMARY KEY,
QUANTIDADE INT NOT NULL,
UNIDADE INT NOT NULL,
TEMPO TIME NOT NULL,
HORAS_MAO_DE_OBRA TIME NOT NULL);

CREATE TABLE IF NOT EXISTS RM(
ID INT PRIMARY KEY,
DATA_RM DATE NOT NULL,
DESCRICAO TEXT NOT NULL);

CREATE TABLE IF NOT EXISTS RS(
ID INT PRIMARY KEY,
QUANTIDADE INT NOT NULL,
DATA_NECESSIDADE DATE NOT NULL);

#ALTER PARA ALTERAR TABELAS
ALTER TABLE CLIENTES ADD EMAIL VARCHAR(50);
ALTER TABLE EMPREGADOS DROP COLUMN Salario;
ALTER TABLE EMPRESAS MODIFY COLUMN Razao_Social varchar(80);
ALTER TABLE FORNECEDORES CHANGE Pessoa_Contato telefone varchar(20);
ALTER TABLE TIPOS_DE_ENDERECOS ADD localidade enum('boa','ruim');
ALTER TABLE TELEFONES DROP column TIPO_ENTIDADE;
ALTER TABLE ENDERECOS MODIFY column Logradouro VARCHAR(80);
ALTER TABLE PRODUTOS CHANGE column DESENHO_PRODUTO qualidade_produto enum('bom','ruim');
ALTER TABLE ENCOMENDAS ADD previsao_chegada date;
ALTER TABLE TIPOS_COMPONENTE DROP column NOME;
ALTER TABLE COMPONENTES MODIFY column NOME VARCHAR(40);
ALTER TABLE MAQUINAS CHANGE column DATA_COMPRA origem_maquina varchar(15);
ALTER TABLE RE ADD tipo_ferramenta varchar(20);
ALTER TABLE RM DROP column DATA_RM;
ALTER TABLE RS MODIFY column QUANTIDADE DECIMAL (10,2);

#DROP PARA EXCLUIR TABELAS
DROP TABLE TIPOS_DE_ENDERECOS;