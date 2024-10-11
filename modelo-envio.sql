use db_atividade_view;

/*
1. Exibir lista de alunos e seus cursos
Crie uma view que mostre o nome dos alunos e as disciplinas em que estão matriculados, incluindo o nome do curso.
*/

create view resumo_alunos AS
SELECT aluno.nome as nome_aluno, curso.nome as nome_curso, disciplina.nome as disciplinas
FROM aluno
JOIN matricula on matricula.id_aluno = aluno.id_aluno
JOIN disciplina on matricula.id_disciplina = disciplina.id_disciplina
JOIN curso on curso.id_curso = disciplina.id_curso
;

/*
2. Exibir total de alunos por disciplina
Crie uma view que mostre o nome das disciplinas e a quantidade de alunos matriculados em cada uma.
*/

CREATE VIEW alunos_por_disciplina AS
SELECT count(aluno.nome) as numero_de_alunos, disciplina.nome as disciplinas FROM aluno
JOIN matricula on matricula.id_aluno = aluno.id_aluno
JOIN disciplina on matricula.id_disciplina = disciplina.id_disciplina
GROUP BY disciplinas
;

/*
3. Exibir alunos e status das suas matrículas
Crie uma view que mostre o nome dos alunos, suas disciplinas e o status da matrícula (Ativo, Concluído, Trancado).
*/

CREATE VIEW status AS
SELECT aluno.nome as nome_aluno, disciplina.nome as nome_disciplina, status FROM aluno
JOIN matricula on matricula.id_aluno = aluno.id_aluno
JOIN disciplina on disciplina.id_disciplina = matricula.id_disciplina
;

/*
4. Exibir professores e suas turmas
Crie uma view que mostre o nome dos professores e as disciplinas que eles lecionam, com os horários das turmas.
*/

create view professores_horarios as
select professor.nome, disciplina.nome, turma.horario from professor
join turma on turma.id_professor = professor.id_professor
join disciplina on disciplina.id_disciplina = turma.id_disciplina
;

/*
5. Exibir alunos maiores de 20 anos
Crie uma view que exiba o nome e a data de nascimento dos alunos que têm mais de 20 anos.
*/
create view datas_nascimento as
select nome, data_nascimento from aluno
where data_nascimento < '2004-01-01'
;

/*
6. Exibir disciplinas e carga horária total por curso
Crie uma view que exiba o nome dos cursos, a quantidade de disciplinas associadas e a carga horária total de cada curso.
*/
create view professor_especialidade as
select curso.nome, disciplina.nome, curso.carga_horaria from curso
join disciplina on disciplina.id_curso = curso.id_curso
;

/*
7. Exibir professores e suas especialidades
Crie uma view que exiba o nome dos professores e suas especialidades.
*/

create view professor_especialidade as
select professor.nome, especialidade from professor
;

/*
8. Exibir alunos matriculados em mais de uma disciplina
Crie uma view que mostre os alunos que estão matriculados em mais de uma disciplina.
*/

create view alunos_mais_de_uma_disciplina as
select aluno.nome, disciplina.nome, count(disciplina.id_disciplina) from aluno
join matricula on aluno.id_aluno = matricula.id_aluno
join disciplina on disciplina.id_disciplina = matricula.id_disciplina
group by aluno.id_aluno, aluno.nome, disciplina.nome
having count(disciplina.id_disciplina) > 1
;

/*
9. Exibir alunos e o número de disciplinas que concluíram
Crie uma view que exiba o nome dos alunos e o número de disciplinas que eles concluíram.
*/

create view disciplinas_terminadas as
select aluno.nome, disciplina.nome, count(disciplina.id_disciplina) from aluno
join matricula on aluno.id_aluno = matricula.id_aluno
join disciplina on disciplina.id_disciplina = matricula.id_disciplina
where matricula.status = 'Concluído'
group by aluno.id_aluno, aluno.nome, disciplina.nome
;


/*
10. Exibir todas as turmas de um semestre específico
Crie uma view que exiba todas as turmas que ocorrem em um determinado semestre (ex.: 2024.1).
*/

create view turmas as
select * from turma
where semestre = '2024.1'
;

/*
11. Exibir alunos com matrículas trancadas
Crie uma view que exiba o nome dos alunos que têm matrículas no status "Trancado".
*/

create view alunos_matriculas_trancadas as
select aluno.nome from aluno
join matricula on aluno.id_aluno = matricula.id_aluno
join disciplina on disciplina.id_disciplina = matricula.id_disciplina
where matricula.status = 'Trancado'
group by aluno.nome
;

select * from alunos_matriculas_trancadas;

/*
12. Exibir disciplinas que não têm alunos matriculados
Crie uma view que exiba as disciplinas que não possuem alunos matriculados.
*/

create view disciplinas_sem_aluno as 
select disciplina.id_disciplina, disciplina.nome, disciplina.descricao
from disciplina
left join matricula on disciplina.id_disciplina = matricula.id_disciplina
where matricula.id_disciplina is null;


/*
13. Exibir a quantidade de alunos por status de matrícula
Crie uma view que exiba a quantidade de alunos para cada status de matrícula (Ativo, Concluído, Trancado).
*/

create view quantidade_status as
select matricula.status, count(matricula.id_aluno) from matricula
group by matricula.status
;

/*
14. Exibir o total de professores por especialidade
Crie uma view que exiba a quantidade de professores por especialidade (ex.: Engenharia de Software, Ciência da Computação).
*/

create view professores as
select professor.especialidade, count(professor.id_professor) from professor
group by professor.especialidade
;

/*
15. Exibir lista de alunos e suas idades
Crie uma view que exiba o nome dos alunos e suas idades com base na data de nascimento.
*/

create view idade_aluno as
select aluno.nome, timestampdiff(year, aluno.data_nascimento, '2024-10-11') from aluno
;

/*
16. Exibir alunos e suas últimas matrículas
Crie uma view que exiba o nome dos alunos e a data de suas últimas matrículas.
*/

create view ultima_matricula as
select aluno.nome, max(matricula.data_matricula) from aluno
join matricula on aluno.id_aluno = matricula.id_aluno
group by aluno.nome
;

/*
17. Exibir todas as disciplinas de um curso específico
Crie uma view que exiba todas as disciplinas pertencentes a um curso específico, como "Engenharia de Software".
*/

create view disciplinas_curso as
select disciplina.nome from disciplina
join curso on curso.id_curso = disciplina.id_curso
where curso.nome = 'Engenharia de Software'
;

/*
18. Exibir os professores que não têm turmas
Crie uma view que exiba os professores que não estão lecionando em nenhuma turma.
*/

create view professor_sem_turma as
select professor.nome from professor
join turma on turma.id_professor = professor.id_professor
where turma.id_professor is null
;

/*
19. Exibir lista de alunos com CPF e email
Crie uma view que exiba o nome dos alunos, CPF e email.
*/

create view detalhes_aluno as
select nome, cpf, email from aluno
;

/*
20. Exibir o total de disciplinas por professor
Crie uma view que exiba o nome dos professores e o número de disciplinas que cada um leciona.
*/

create view disciplina_por_professor as
select professor.nome, count(turma.id_disciplina) from professor
join turma on turma.id_professor = professor.id_professor
group by professor.id_professor
;
