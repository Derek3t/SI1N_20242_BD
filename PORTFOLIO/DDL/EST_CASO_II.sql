#criando schema
create schema EC2_SI1N;

#usando o banco
use EC2_SI1N;


#tabela de passageiros
create table if not exists passageiros(
pass_id int primary key,
pass_nome varchar(40) not null,
pass_cpf varchar(14) not null,
pass_tel varchar(16) not null,
pass_end varchar(40) not null,
reserv_id int not null,
constraint fk_reserv_id foreign key (reserv_id) references reservas(reserv_id)
);


#tabela de voos
create table if not exists voos(
voo_origem varchar(40) not null,
voo_destino varchar(40) not null,
voo_hora_partida datetime not null,
voo_hora_chegada datetime not null,
aeron_id int not null,
pass_id int not null,
func_id int not null,
aerop_id int not null,
voo_id int not null,
constraint fk_aeron_id foreign key (aeron_id) references aeronaves(aeron_id),
constraint fk_pass_id foreign key (pass_id) references passageiros(pass_id),
constraint fk_func_id foreign key (func_id) references funcionarios(func_id),
constraint fk_aerop_id foreign key (aerop_id) references aeroportos(aerop_id),
constraint fk_voo_id foreign key (voo_id) references voos(id_voo)
);


#tabela aeroportos
create table if not exists aeroportos(
aerop_id int primary key,
aerop_nome varchar(40) not null,
aerop_local varchar(40) not null,
aerop_pais varchar(25) not null,
aerop_longitude varchar(20) not null,
aerop_latitude varchar(20) not null,
aeron_id int not null,
voo_id int not null,
pass_id int not null,
constraint fk_aeron_id foreign key (aeron_id) references aeronaves (aeron_id),
constraint fk_voo_id foreign key (voo_id) references voos(voo_id),
constraint fk_pass_id foreign key (pass_id) references passageiros (pass_id)
);


#tabela de aeronaves 
create table if not exists aeronaves(
aeron_id varchar(15) primary key,
aeron_prefixo varchar (10) not null,
aeron_anofabr date not null,
aeron_capacidade int not null,
aeron_fabricante varchar(30),
equip_id int not null,
aerop_id int not null,
func_id int not null,
voo_id int not null,
constraint fk_equip_id foreign key (equip_id) references equipes (equip_id),
constraint fk_aerop_id foreign key (aerop_id) references aeroportos(aerop_id),
constraint fk_func_id foreign key (func_id) references funcionarios(func_id),
constraint fk_voo_id foreign key (voo_id) references voos(voo_id)
);


#tabela de funcionarios
create table if not exists funcionarios(
func_id int primary key,
func_funcao varchar(12) not null,
func_nome varchar(20) not null,
func_datanasc date not null,
func_tel int not null,
equip_id int not null,
voo_id int not null,
constraint fk_func_id foreign key (func_id) references funcionarios(func_id),
constraint fk_equip_id foreign key (equip_id) references equipes (equip_id),
constraint fk_voo_id foreign key (voo_id) references voos(voo_id)
);


#tabela de reservas
create table if not exists reservas(
reserv_id int primary key,
pass_id int primary key,
voo_id int primary key,
reserv_date datetime not null,
#restrição nas chaves estangeiras
constraint fk_passageiros foreign key(pass_id) references passageiros(pass_id),
constraint fk_voos foreign key(voo_id) references voos(voo_id)
);


#tabela equipes
create table if not exists equipes(
equip_id int primary key,
voo_id int not null,
func_id int not null,
equip_funcao varchar(10),
constraint fk_voos foreign key(voo_id) references voos(voo_id),
constraint fk_funcionarios foreign key(func_id) references funcionarios (func_id)
);

#ALTER PARA ALTERAR TABELAS
ALTER TABLE passageiros ADD pass_email VARCHAR(40);  # Adicionando email do passageiro
ALTER TABLE voos ADD voo_duracao INT;  # Adicionando duração do voo em minutos
ALTER TABLE aeroportos MODIFY COLUMN aerop_nome VARCHAR(100);  # Modificando tamanho do nome do aeroporto
ALTER TABLE aeronaves CHANGE COLUMN aeron_fabricante aeron_construtora VARCHAR(200);  # Alterando nome da coluna do fabricante
ALTER TABLE funcionarios ADD func_email VARCHAR(100);  # Adicionando email do funcionário
ALTER TABLE reservas ADD reserv_status VARCHAR(20);  # Adicionando status da reserva
ALTER TABLE equipes DROP COLUMN equip_funcao;  # Removendo coluna de função da equipe


#DROP PARA EXCLUIR TABELAS
drop table equipes;