-- Afig dades d'exemple per a 6 estudiants. Almenys un d'ells 
-- no ha de tindre any i almenys un ha de tindre les dades 
-- en ordre "no natural".

INSERT INTO estudiants VALUES (23, 'Michael', 'Jordan', 'jordan@jordan.com');
INSERT INTO estudiants VALUES (32, 'Earvin', 'Johnson', 'magic@johnson.com');
INSERT INTO estudiants VALUES (34, 'Hakeem', 'Olajuwon', 'hakeem@olaju.com');
INSERT INTO estudiants (nia, nom, cognoms) VALUES (33, 'Larry', 'Bird');
INSERT INTO estudiants (nia, nom, cognoms, email) VALUES (11, 'Isiah', 'Thomas', NULL);
INSERT INTO estudiants (nom, cognoms, nia) VALUES ('Dominique','Wilkins', 21);

-- Col·lisió de clau:
-- INSERT INTO estudiants (nia, nom, cognoms) VALUES (33, 'Pat', 'Ewing');
