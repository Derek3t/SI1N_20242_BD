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

insert into  clientes(nome_cli,
cpf_cli,
data_nasc_cli,
end_cli,
status_fid_cli,
id_prod,
id_fornec,
id_vend,
id_pag)
values ('Ronaldo','492.928.482-21','23/11/2001','Avenida Linha Reta, 456, CEP: 98765-432','alta fidelidade','13','13','13','13');

update clientes
set nome_cli = 'Leonardo' 
where data_nasc_cli = '23/11/2001';

delete from clientes
where nome_cli = 'Ronaldo';