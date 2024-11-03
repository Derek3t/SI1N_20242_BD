#criando schema
create schema EC5_SI1N;

#usando banco
use EC5_SI1N;

#criando tabela cliente
create table if not exists clientes(
id_cli int primary key,
nome_cli varchar(20) not null,
cpf_cli int not null,
data_nasc_cli date not null,
end_cli varchar(30) not null,
status_fid_cli varchar(20) not null,
id_prod int not null,
id_fornec int not null,
id_vend int not null,
id_pag int not null,
constraint fk_id_prod foreign key (id_prod) references produtos(id_prod),
constraint fk_id_fornec foreign key(id_fornec) references fornecedores(id_fornec),
constraint fk_id_vend foreign key(id_vendas) references vendas (id_vendas),
constraint fk_id_pag foreign key (id_pagamentos) references pagamentos(id_pag)
);

#criando tabela produtos
create table if not exists produtos(
id_prod int primary key,
cat_prod varchar(10) not null,
disp_prod int not null,
preco_prod varchar(100) not null,
id_fornec int not null,
constraint fk_id_fornec foreign key (id_fornec) references fornecedores (id_fornec)
);

#criando tabela fornecedores
create table if not exists fornecedores(
id_fornec int primary key,
nome_fornec varchar(20) not null,
tel_fornec varchar(12),
prod_fornec varchar (20),
id_prod int not null,
constraint fk_id_prod foreign key (id_prod) references produtos (id_prod)
);

#criando tabela vendas
create table if not exists vendas(
id_vend int primary key,
quant_vend varchar(10) not null,
id_prod int not null,
id_fornec int not null,
id_cli int not null,
constraint fk_id_prod foreign key (id_prod) references produtos(id_prod),
constraint fk_id_fornec foreign key (id_fornec) references fornecedores(id_fornec),
constraint fk_id_fornec foreign key (id_cli) references clientes(id_cli)
);

#criando tabela pagamentos
create table if not exists pagamentos(
id_pag int primary key,
form_pag varchar (10) not null,
id_prod int not null,
id_vend int not null,
id_cli int not null,
constraint fk_id_prod foreign key (id_prod) references produtos(id_prod),
constraint fk_id_vend foreign key (id_vend) references vendas(id_vend),
constraint fk_id_cli foreign key (id_cli) references clientes(id_cli)
);


#ALTER PARA ALTERAR TABELAS 
ALTER TABLE clientes ADD telefone_cli VARCHAR(15);  # Adicionando telefone do cliente
ALTER TABLE produtos ADD descricao_prod VARCHAR(255);  # Adicionando descrição do produto
ALTER TABLE fornecedores MODIFY COLUMN nome_fornec VARCHAR(200);  # Modificando tamanho do nome do fornecedor
ALTER TABLE fornecedores DROP COLUMN prod_fornec;  # Removendo coluna de produto do fornecedor
ALTER TABLE vendas CHANGE COLUMN quant_vend lotes_prod VARCHAR(200);  # Alterando nome da coluna de quantidade vendida para lotes
ALTER TABLE pagamentos ADD status_pagamento VARCHAR(20);  # Adicionando status do pagamento


#DROP PARA EXCLUIR TABELAS
drop table fornecedores;