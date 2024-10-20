-- COMPONENT(codi,nom)
-- CP: codi
-- 
-- CATEGORIA(codi,nom)
-- CP: codi
-- 
-- ARTICLE(codi,nom,codiCategoria)
-- CP: codi
-- CAli: codiCategoria -> CATEGORIA(codi)
-- 
-- ES_PART_DE(codiComponent,codiArticle)
-- CP: (codiComponent,codiCaegoria)
-- CAli: codiComponent -> COMPONENT(codi)
-- CAli: codiArticle -> ARTICLE(codi)

-- Lucía, Adrián

create table component(
    codi numeric(6) primary key,
     nom varchar(30));

insert into component values(1,'Tuerca');
insert into component values(2,'Caragol');

create table categoria(
    codi numeric(6) primary key,
     nom varchar(30));

insert into categoria values(1,'Herramienta');
insert into categoria values(2,'Ordenador');


create table article(
    codi numeric(6) primary key,
     nom varchar(30),
     codiCategoria numeric(6));

insert into article values(1,'Descaragolador',1);
insert into article values(2,'Grafica',2);


create table es_part_de(
    codiComponent numeric(6),
     codiArticle numeric(6),
     primary key(codiComponent,codiArticle)
     );

insert into es_part_de values(1,1);
insert into es_part_de values(2,2);

SELECT component.nom, article.nom, categoria.nom
FROM component, article, categoria, es_part_de
WHERE article.codiCategoria = categoria.codi
    AND es_part_de.codiComponent = component.codi
    AND es_part_de.codiArticle = article.codi;


