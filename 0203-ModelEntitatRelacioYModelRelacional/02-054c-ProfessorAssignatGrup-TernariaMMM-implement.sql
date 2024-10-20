-- PROFESSOR (codi, nom)
-- CP: codi
-- 
-- GRUP (codi, nom)
-- CP: codi
-- 
-- ASSIGNATURA (codi, nom)
-- CP: codi
-- 
-- IMPARTIR (codiProf, codiGrup, codiAssig)
-- CP: (codiProf, codiGrup, codiAssig)
-- C.Ali.: codiProf -> PROFESSOR
-- C.Ali.: codiGrup -> GRUP
-- C.Ali.: codiAssig -> ASSIGNATURA

-- Carlos y Marcos

create table professor(
    codi varchar(5) primary key,
    nom varchar(30)
);

create table grup(
    codi varchar(5) primary key,
    nom varchar(30)
);
 
create table asignatura(
    codi varchar(5) primary key,
    nom varchar(30)
);
    
create table imparteix(
    codiProfessor varchar(5),
    codiGrup varchar(5),
    codiAsignatura varchar(5),
    primary key(codiProfessor,codiGrup,codiAsignatura),
    foreign key(codiProfessor) references professor(codi)       
    foreign key(codiGrup) references grup(codi)     
    foreign key(codiAsignatura) references asignatura(codi)     
);

insert into professor values('n', 'Nacho');
insert into professor values('j', 'Javier');
insert into professor values('m', 'Marc');

insert into grup values('daw1', 'Daw 1º');
insert into grup values('daw2', 'Daw 2º');
insert into grup values('dam1', 'Dam 1º');

insert into asignatura values('bbdd', 'Bases de datos');
insert into asignatura values('pr', 'Programacion');
insert into asignatura values('ing', 'Inglés');

insert into imparteix values('n', 'daw1', 'bbdd');
insert into imparteix values('j', 'dam1', 'bbdd');
insert into imparteix values('m', 'daw1', 'ing');

-- Veure tots els professors, grup y assignatura
select * from professor;
select * from grup;
select * from asignatura;

-- Veure nom dels professors al costat dels noms dels cursos al costat del nom dels grups 
-- que impartix (forma correcta)

select professor.nom, grup.nom, asignatura.nom
from professor, grup, asignatura, imparteix
where imparteix.codiProfessor = professor.codi
    and imparteix.codiGrup = grup.codi
    and imparteix.codiAsignatura = asignatura.codi;

