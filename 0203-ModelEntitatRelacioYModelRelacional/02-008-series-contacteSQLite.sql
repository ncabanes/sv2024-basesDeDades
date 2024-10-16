create table series(
    codi varchar(5) primary key,
    titol varchar(30), 
    anyInici numeric(4), 
    temporadas numeric(4), 
    tematica varchar(50)
);

insert into series values('rea', 'Reacher', 2022, 3, 'Acción');
insert into series values('tb', 'The bear', 2022, 2, 'Drama');
insert into series values('st', 'Stranger things', 2016, 4, 'Ciencia-ficción');

select * from series;
