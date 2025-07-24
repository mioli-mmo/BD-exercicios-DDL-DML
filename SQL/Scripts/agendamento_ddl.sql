CREATE SCHEMA agendamento_consulta;

CREATE TABLE agendamento_consulta.Pessoa(
cpf CHAR(11),
email VARCHAR(50) NOT NULL,
nome VARCHAR(150) NOT NULL,
data_nasc DATE NOT NULL,
endereco VARCHAR(300) NOT NULL,
telefone VARCHAR(15),
CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
CONSTRAINT pessoa_email_nome_un UNIQUE (email, nome)
);

CREATE TABLE agendamento_consulta.Paciente(
cpf_pessoa CHAR(11),
senha VARCHAR(20) NOT NULL,
plano_saude BOOLEAN NOT NULL DEFAULT FALSE,
CONSTRAINT paciente_pk PRIMARY KEY (cpf_pessoa),
CONSTRAINT paciente_pessoa_fk FOREIGN KEY (cpf_pessoa) REFERENCES agendamento_consulta.Pessoa(cpf)
);

CREATE TABLE agendamento_consulta.Medico(
cpf_pessoa CHAR(11),
crm VARCHAR(10) NOT NULL,
CONSTRAINT medico_pk PRIMARY KEY (cpf_pessoa),
CONSTRAINT medico_pessoa_fk FOREIGN KEY (cpf_pessoa) REFERENCES agendamento_consulta.Pessoa(cpf),
CONSTRAINT medico_crm_un UNIQUE (crm)
);

CREATE TABLE agendamento_consulta.Agendamento(
cpf_paciente CHAR(11),
cpf_medico CHAR(11),
dh_consulta TIMESTAMP,
dh_agendamento TIMESTAMP NOT NULL,
valor_consulta FLOAT NOT NULL DEFAULT 0.0,
CONSTRAINT agendamento_pk PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
CONSTRAINT agendamento_paciente_fk FOREIGN KEY (cpf_paciente) REFERENCES agendamento_consulta.Paciente(cpf_pessoa),
CONSTRAINT agendamento_medico_fk FOREIGN KEY (cpf_medico) REFERENCES agendamento_consulta.Medico(cpf_pessoa)
);

CREATE TABLE agendamento_consulta.Especialidade(
id INT GENERATED ALWAYS AS IDENTITY,
descricao VARCHAR(300) NOT NULL,
CONSTRAINT especialidade_pk PRIMARY KEY (id)
);

CREATE TABLE agendamento_consulta.Medico_Especialidade(
cpf_medico CHAR(11),
id_especialidade INT,
CONSTRAINT med_esp_pk PRIMARY KEY (cpf_medico, id_especialidade),
CONSTRAINT med_esp_medico_fk FOREIGN KEY (cpf_medico) REFERENCES agendamento_consulta.Medico(cpf_pessoa),
CONSTRAINT med_esp_especialidade_fk FOREIGN KEY (id_especialidade) REFERENCES agendamento_consulta.Especialidade(id)
);
