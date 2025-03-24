-- 6.33

-- Crea una funció anomenada "CiutatsPais", que retorne una cadena de text 
-- formada els noms de les ciutats que pertanyen al país el nom del qual 
-- s'indique com a paràmetre, ordenades alfabèticament i separades per comes, 
-- o "(No trobat)"si eixe país no existix. En esta versió has d'emprar LOOP.

create or replace function CiutatPais (nomPais in varchar2)
return varchar2 is
    text varchar2(200);
    vCNom ciutats.nom%type;
    cursor paisosCiutats is
        select c.nom from ciutats c join paisos p
        on c.codiPais = p.codi where p.nom = nomPais;
begin
    open paisosCiutats;
    loop
    fetch paisosCiutats into vCNom;
    exit when paisosCiutats%NOTFOUND;
    text := text || ',' || vCNom;
    end loop;

    if paisosCiutats%ROWCOUNT = 0 then
        text := '(No trobat)';
    end if;
    close paisosCiutats;
    return text;
end CiutatPais;

begin
    dbms_output.put_line(CiutatPais('China'));
end;
