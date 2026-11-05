-- criando tabela de professores
CREATE TABLE professores (
 cpf_professor CHAR(11) PRIMARY KEY,
nome_professor VARCHAR(80)
);

-- visualizando tabela professores
SELECT * 
FROM professores

-- criando disciplinas
CREATE TABLE disciplinas (
 id_disciplina INTEGER PRIMARY KEY,
 nome_disciplina VARCHAR(50) NOT NULL

);

-- criando tabela turmas
CREATE TABLE turmas (
  id_turma SERIAL,
  sala VARCHAR(20) NOT NULL,
  cpf_professor  CHAR(11),
  id_disciplina INTEGER,
    CONSTRAINT pk_id_turma
         PRIMARY KEY(id_turma),
       CONSTRAINT fk_cpf_professor
           FOREIGN KEY(cpf_professor)REFERENCES professores(cpf_professor),
               CONSTRAINT id_disciplina
                     FOREIGN KEY(id_disciplina) REFERENCES disciplinas(id_disciplina)
	  
);



