-- INSERT
INSERT INTO agendamento_consulta.Pessoa VALUES ('002','pp@email.com','Pedro I','1479-01-10','R. Vasco',NULL);
INSERT INTO agendamento_consulta.Pessoa VALUES ('003','ps@email.com','Pedro II','1516-02-10','R. Flamengo','5501');
INSERT INTO agendamento_consulta.Pessoa VALUES ('001','dj@email.com','D João VI','1415-12-01','R. Portugal',NULL);
INSERT INTO agendamento_consulta.Pessoa VALUES ('004','jj@email.com','JJ Xavier','1746-11-12','R. Minas','5502');

INSERT INTO agendamento_consulta.Paciente VALUES ('002','senha1',FALSE);
INSERT INTO agendamento_consulta.Paciente VALUES ('003','senha2',TRUE);

INSERT INTO agendamento_consulta.Medico VALUES ('001','111');
INSERT INTO agendamento_consulta.Medico VALUES ('004','112');

INSERT INTO agendamento_consulta.Especialidade(id,descricao) VALUES (11,'Pediatra');
INSERT INTO agendamento_consulta.Especialidade(id,descricao) VALUES (12,'Cardiologista');
INSERT INTO agendamento_consulta.Especialidade(id,descricao) VALUES (13,'Ortopedista');

INSERT INTO agendamento_consulta.Medico_Especialidade VALUES ('001',11);
INSERT INTO agendamento_consulta.Medico_Especialidade VALUES ('004',11);
INSERT INTO agendamento_consulta.Medico_Especialidade VALUES ('004',12);
INSERT INTO agendamento_consulta.Medico_Especialidade VALUES ('004',13);

INSERT INTO agendamento_consulta.Agendamento VALUES ('002','001','1782-04-14 16:00:00','1782-03-14 10:04:45',80);
INSERT INTO agendamento_consulta.Agendamento VALUES ('002','004','1782-04-15 10:00:00','1782-03-14 10:04:45',100);
INSERT INTO agendamento_consulta.Agendamento VALUES ('002','004','1783-05-17 08:00:00','1783-05-10 16:32:00',100);
INSERT INTO agendamento_consulta.Agendamento VALUES ('003','001','1783-05-17 08:30:00','1783-05-09 09:05:56',0);

-- UPDATE
UPDATE agendamento_consulta.Pessoa SET data_nasc = '1416-12-01' WHERE nome = 'D João VI';
UPDATE agendamento_consulta.Pessoa SET telefone = '5503', email = 'pf@email.com' WHERE nome = 'Pedro I';
UPDATE agendamento_consulta.Pessoa SET telefone = CONCAT('9',telefone) WHERE telefone IS NOT NULL;
UPDATE agendamento_consulta.Agendamento SET dh_consulta = '1783-05-19 08:00:00', valor_consulta = 150.0 WHERE dh_consulta = '1783-05-17 08:00:00';
UPDATE agendamento_consulta.Agendamento SET dh_consulta = '1783-05-19 08:30:00', valor_consulta = 150.0 WHERE dh_consulta = '1783-05-17 08:30:00';
DELETE FROM agendamento_consulta.Medico_Especialidade WHERE cpf_medico = '004' AND id_especialidade = 12;

-- DELETE
DELETE FROM agendamento_consulta.Agendamento WHERE cpf_paciente = '002' AND dh_consulta = '1783-05-17 08:00:00';
DELETE FROM agendamento_consulta.Agendamento WHERE cpf_medico = '001' AND valor_consulta = 0;
DELETE FROM agendamento_consulta.Paciente WHERE plano_saude = TRUE OR cpf_pessoa IN (
  SELECT cpf FROM agendamento_consulta.Pessoa WHERE telefone IS NULL
);
DELETE FROM agendamento_consulta.Medico_Especialidade WHERE cpf_medico = '004';
DELETE FROM agendamento_consulta.Agendamento WHERE cpf_medico = '004';
DELETE FROM agendamento_consulta.Medico WHERE cpf_pessoa = '004';
DELETE FROM agendamento_consulta.Pessoa WHERE cpf = '004';
