-- 1. Listar todos os dados da tabela Pessoa
SELECT *
  FROM agendamento_consulta.Pessoa;

-- 2. Listar nome, e-mail e data de nascimento das pessoas cadastradas
SELECT nome       AS "nome",
       email      AS "e-mail",
       data_nasc  AS "data de nascimento"
  FROM agendamento_consulta.Pessoa;

-- 3. Listar nome, e-mail e data de nascimento da 3ª à 8ª pessoa cadastrada
SELECT nome       AS "nome",
       email      AS "e-mail",
       data_nasc  AS "data de nascimento"
  FROM agendamento_consulta.Pessoa
 ORDER BY cpf
 OFFSET 2 LIMIT 6;

-- 4. Listar nome, e-mail e idade das pessoas cadastradas
SELECT nome       AS "nome",
       email      AS "e-mail",
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nasc)) AS "idade"
  FROM agendamento_consulta.Pessoa;

-- 5. Listar a quantidade de agendamentos
SELECT COUNT(*) AS "quantidade de agendamentos"
  FROM agendamento_consulta.Agendamento;

-- 6. Listar data/hora das consultas e os respectivos valores com desconto de 5%, formatados com "R$"
SELECT dh_consulta                                                    AS "data/hora da consulta",
       CONCAT('R$ ', TO_CHAR(valor_consulta * 0.95, 'FM9999990.00')) AS "valor com desconto"
  FROM agendamento_consulta.Agendamento;

-- 7. Listar nome, cpf e e-mail dos pacientes que não possuem plano de saúde
SELECT p.nome  AS "nome",
       p.cpf   AS "cpf",
       p.email AS "e-mail"
  FROM agendamento_consulta.Paciente pa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf
 WHERE pa.plano_saude = FALSE;

-- 8. Listar os agendamentos registrados no mesmo mês e ano da data de agendamento
SELECT *
  FROM agendamento_consulta.Agendamento
 WHERE EXTRACT(YEAR  FROM dh_agendamento) = EXTRACT(YEAR  FROM dh_consulta)
   AND EXTRACT(MONTH FROM dh_agendamento) = EXTRACT(MONTH FROM dh_consulta);

-- 9. Listar cpf, nome e e-mail dos pacientes que não possuem telefone
SELECT p.cpf   AS "cpf",
       p.nome  AS "nome",
       p.email AS "e-mail"
  FROM agendamento_consulta.Paciente pa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf
 WHERE p.telefone IS NULL;

-- 10. Listar a data das consultas cujo valor está entre R$ 50.00 e R$ 100.00
SELECT CAST(dh_consulta AS DATE) AS "data da consulta"
  FROM agendamento_consulta.Agendamento
 WHERE valor_consulta BETWEEN 50.00 AND 100.00;

-- 11. Listar cpf, nome e e-mail dos pacientes que moram em "Natal"
SELECT p.cpf   AS "cpf",
       p.nome  AS "nome",
       p.email AS "e-mail"
  FROM agendamento_consulta.Paciente pa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf
 WHERE p.endereco LIKE '%Natal%';

-- 12. Listar cpf, nome, e-mail e data de nascimento dos pacientes ordenados pela data de nascimento
SELECT p.cpf        AS "cpf",
       p.nome       AS "nome",
       p.email      AS "e-mail",
       p.data_nasc  AS "data de nascimento"
  FROM agendamento_consulta.Paciente pa
  JOIN agendamento_consulta.Pessoa p
    ON pa.cpf_pessoa = p.cpf
 ORDER BY p.data_nasc;

-- 13. Listar a quantidade de pacientes que não possuem plano de saúde
SELECT COUNT(*) AS "quantidade sem plano"
  FROM agendamento_consulta.Paciente
 WHERE plano_saude = FALSE;

-- 14. Listar o maior e o menor valor das consultas agendadas para cada dia que contém consulta
SELECT CAST(dh_consulta AS DATE) AS "data",
       MAX(valor_consulta)       AS "valor máximo",
       MIN(valor_consulta)       AS "valor mínimo"
  FROM agendamento_consulta.Agendamento
 GROUP BY CAST(dh_consulta AS DATE);

-- 15. Listar a média dos valores das consultas agendadas para o mês de Dezembro
SELECT AVG(valor_consulta) AS "média de dezembro"
  FROM agendamento_consulta.Agendamento
 WHERE EXTRACT(MONTH FROM dh_consulta) = 12;

-- 16. Listar nome e e-mail das pessoas que agendaram alguma consulta para o dia do seu aniversário
SELECT DISTINCT p.nome  AS "nome",
                p.email AS "e-mail"
  FROM agendamento_consulta.Agendamento a
  JOIN agendamento_consulta.Pessoa p
    ON a.cpf_paciente = p.cpf
 WHERE EXTRACT(MONTH FROM a.dh_consulta) = EXTRACT(MONTH FROM p.data_nasc)
   AND EXTRACT(DAY   FROM a.dh_consulta) = EXTRACT(DAY   FROM p.data_nasc);

-- 17. Listar o nome, e-mail, cpf dos médicos e as suas respectivas especialidades
SELECT p.nome       AS "nome do médico",
       p.email      AS "e-mail do médico",
       m.cpf_pessoa AS "cpf do médico",
       e.descricao  AS "especialidade"
  FROM agendamento_consulta.Medico_Especialidade me
  JOIN agendamento_consulta.Medico       m
    ON me.cpf_medico = m.cpf_pessoa
  JOIN agendamento_consulta.Pessoa       p
    ON m.cpf_pessoa = p.cpf
  JOIN agendamento_consulta.Especialidade e
    ON me.id_especialidade = e.id;

-- 18. Listar a quantidade de consultas para cada médico
SELECT m.cpf_pessoa       AS "cpf do médico",
       p.nome             AS "nome do médico",
       COUNT(a.cpf_medico) AS "total de consultas"
  FROM agendamento_consulta.Agendamento a
  JOIN agendamento_consulta.Medico   m
    ON a.cpf_medico = m.cpf_pessoa
  JOIN agendamento_consulta.Pessoa   p
    ON m.cpf_pessoa = p.cpf
 GROUP BY m.cpf_pessoa, p.nome;