create schema estcasoiv;
use estcasoiv;
create table if not exists alunos(
id int primary key,
nome varchar(30) not null,
cpf varchar(15) not null,
data_nascimento date not null,
endereco varchar(50) not null,
modalidade varchar(20) not null);

create table if not exists instrutores(
id int primary key,
nome varchar (50) not null);

create table if not exists modalidades(
id int primary key,
nome varchar (50) not null);

create table if not exists planos_treinamento(
idPlano INT PRIMARY KEY,
idAluno INT,
idInstrutor INT,
descricao TEXT,
data_atualizacao DATE,
constraint fk_aluno FOREIGN KEY (idAluno) REFERENCES Alunos(id_aluno),
constraint fk_instrutor FOREIGN KEY (idInstrutor) REFERENCES Instrutores(id_instrutor));

create table if not exists aulas(
ID_aula INT primary key,
HORARIO TIME NOT NULL,
CAPACIDADE INT NOT NULL,
INSTRUTOR VARCHAR(50) not null,
id_modalidade int,
id_instrutor int,
constraint fk_modalidade foreign key (id_modalidade) references modalidades(id_),
constraint fk_instrutor foreign key (id_instrutor) references instrutores(id));

create table if not exists pagamentos(
id_pagamento int primary key,
data_pagamento date not null,
valor decimal(5,2),
id_aluno int,
constraint fk_aluno FOREIGN KEY (id_aluno) REFERENCES alunos(id),
status enum('pago','pendente'));

#ALTER PARA ALTERAR TABELAS
alter table alunos add email varchar(20);
alter table instrutores drop column nome;
alter table modalidades modify column nome varchar (200);
alter table planos_treinamento change column idaluno id_aluno int primary key;
alter table aulas add turno varchar(10);
alter table pagamentos add form_pagamento varchar(10);

#DROP PARA EXCLUIR TABELAS
drop table planos_treinamento;