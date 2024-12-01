CREATE DATABASE FortesEngenharia;
USE FortesEngenharia;


CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    Tipo_Usuario ENUM('Admin', 'Donatário') NOT NULL
);

CREATE TABLE AcaoSocial (
    ID_Acao INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(255) NOT NULL,
    Descricao TEXT NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Termino DATE NOT NULL,
    Status ENUM('Ativa', 'Concluída', 'Cancelada') NOT NULL
);


CREATE TABLE Edital (
    ID_Edital INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(255) NOT NULL,
    Descricao TEXT NOT NULL,
    Data_Publicacao DATE NOT NULL,
    Prazo_Submissao DATE NOT NULL,
    Acao_Social_ID INT,
    FOREIGN KEY (Acao_Social_ID) REFERENCES AcaoSocial(ID_Acao) ON DELETE CASCADE
);

CREATE TABLE Feedback (
    ID_Feedback INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT,
    ID_Acao INT,
    Comentario TEXT NOT NULL,
    Nota INT CHECK (Nota BETWEEN 1 AND 5),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Acao) REFERENCES AcaoSocial(ID_Acao) ON DELETE CASCADE
);

CREATE TABLE Progresso (
    ID_Progresso INT PRIMARY KEY AUTO_INCREMENT,
    ID_Acao INT,
    Data DATE NOT NULL,
    Status ENUM('Em andamento', 'Concluído', 'Cancelado') NOT NULL,
    Descricao TEXT NOT NULL,
    FOREIGN KEY (ID_Acao) REFERENCES AcaoSocial(ID_Acao) ON DELETE CASCADE
);
