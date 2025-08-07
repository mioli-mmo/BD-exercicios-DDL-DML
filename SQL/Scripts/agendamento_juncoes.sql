-- 1. Listar o nome, e-mail e crm dos médicos
SELECT p.nome  AS "nome",
       p.email AS "e-mail",
       m.crm   AS "crm"
  FROM agendamento_consulta.Medico m
  JOIN agendamento_consulta.Pessoa p
    ON m.cpf_pessoa = p.cpf;

-- 2. Listar o nome, e-mail e senha dos pacientes
SELECT p.nome   AS "nome",
       p.email  AS "e-mail",
       pa.senha AS "senha"
  FROM agendamento_consulta.Paciente pa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf;

-- 3. Listar os CRM dos médicos e as descrições das suas respectivas especialidades
SELECT m.crm         AS "crm",
       e.descricao   AS "especialidade"
  FROM agendamento_consulta.Medico m
  JOIN agendamento_consulta.Medico_Especialidade me
    ON m.cpf_pessoa = me.cpf_medico
  JOIN agendamento_consulta.Especialidade e
    ON me.id_especialidade = e.id;

-- 4. Listar o crm de todos os médicos cardiologistas
SELECT m.crm AS "crm"
  FROM agendamento_consulta.Medico m
  JOIN agendamento_consulta.Medico_Especialidade me
    ON m.cpf_pessoa = me.cpf_medico
  JOIN agendamento_consulta.Especialidade e
    ON me.id_especialidade = e.id
 WHERE e.descricao ILIKE 'Cardiologista';

-- 5. Listar o nome, CPF, crm e senha dos pacientes que também são médicos
SELECT p.nome        AS "nome",
       p.cpf         AS "cpf",
       m.crm         AS "crm",
       pa.senha      AS "senha"
  FROM agendamento_consulta.Pessoa p
  JOIN agendamento_consulta.Medico m
    ON p.cpf = m.cpf_pessoa
  JOIN agendamento_consulta.Paciente pa
    ON p.cpf = pa.cpf_pessoa;

-- 6. Listar o nome dos médicos e as respectivas quantidades de consultas agendadas
SELECT p.nome             AS "nome do médico",
       COUNT(a.cpf_medico) AS "quantidade de consultas"
  FROM agendamento_consulta.Medico m
  LEFT JOIN agendamento_consulta.Agendamento a
    ON m.cpf_pessoa = a.cpf_medico
  JOIN agendamento_consulta.Pessoa p
    ON m.cpf_pessoa = p.cpf
 GROUP BY p.nome;

-- 7. Listar as especialidades e a quantidade de médicos cadastrados nessa especialidade
SELECT e.descricao          AS "especialidade",
       COUNT(me.cpf_medico) AS "quantidade de médicos"
  FROM agendamento_consulta.Especialidade e
  LEFT JOIN agendamento_consulta.Medico_Especialidade me
    ON e.id = me.id_especialidade
 GROUP BY e.descricao;

-- 8. Listar os dados dos agendamentos, exibindo: (a) nome e e-mail do paciente, (b) data/hora e valor da consulta, (c) nome e crm dos médicos
SELECT p.nome              AS "paciente",
       p.email             AS "e-mail do paciente",
       a.dh_consulta       AS "data/hora da consulta",
       a.valor_consulta    AS "valor",
       m.crm               AS "crm do médico",
       mp.nome             AS "nome do médico"
  FROM agendamento_consulta.Agendamento a
  JOIN agendamento_consulta.Paciente pa
    ON a.cpf_paciente = pa.cpf_pessoa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf
  JOIN agendamento_consulta.Medico m
    ON a.cpf_medico = m.cpf_pessoa
  JOIN agendamento_consulta.Pessoa mp
    ON m.cpf_pessoa = mp.cpf;

-- 9. Listar a data/hora das consultas agendadas para todos os cardiologistas cadastrados
SELECT a.dh_consulta AS "data/hora da consulta"
  FROM agendamento_consulta.Agendamento a
  JOIN agendamento_consulta.Medico m
    ON a.cpf_medico = m.cpf_pessoa
  JOIN agendamento_consulta.Medico_Especialidade me
    ON m.cpf_pessoa = me.cpf_medico
  JOIN agendamento_consulta.Especialidade e
    ON me.id_especialidade = e.id
 WHERE e.descricao ILIKE 'Cardiologista';

-- 10. Listar o nome e CRM dos médicos e a média das suas consultas agendadas para o mês de dezembro/2020
SELECT p.nome                 AS "nome do médico",
       m.crm                  AS "crm",
       AVG(a.valor_consulta) AS "média consultas dezembro 2020"
  FROM agendamento_consulta.Medico m
  JOIN agendamento_consulta.Pessoa p
    ON m.cpf_pessoa = p.cpf
  LEFT JOIN agendamento_consulta.Agendamento a
    ON m.cpf_pessoa = a.cpf_medico
   AND EXTRACT(MONTH FROM a.dh_consulta) = 12
   AND EXTRACT(YEAR  FROM a.dh_consulta) = 2020
 GROUP BY p.nome, m.crm;
