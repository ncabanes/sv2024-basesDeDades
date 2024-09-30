.open cursos1M

create table professors(codi varchar(5) primary key, nom varchar(30));
insert into professors values("n", "Nacho");
insert into professors values("j", "Javier");

create table cursos(codi varchar(5) primary key, nom varchar(30), inici varchar(10), codi_professor varchar(5));
insert into cursos values("j", "Java", "2022-10-03", "n");
insert into cursos values("c#", "C#", "2022-09-20", "n");
insert into cursos values("o", "Oracle", "2022-10-10", "j");
  
-- Veure tots els professors

select * from professors;

-- Veure tots els cursos

select * from cursos;

-- Veure nom dels professors al costat dels noms dels cursos 
-- que impartix (primera aproximació, incorrecta)

select professors.nom, cursos.nom 
from cursos, professors;

-- Veure nom dels professors al costat dels noms dels cursos
-- que impartix (forma correcta)

select professors.nom, cursos.nom 
from cursos, professors 
where cursos.codi_professor = professors.codi;
