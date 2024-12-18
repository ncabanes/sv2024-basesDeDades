-- Mostra nom i plataforma dels jocs l'any dels quals siga nul

SELECT nom, plataforma FROM jocs WHERE any IS NULL;

-- Mostra nom i plataforma dels jocs l'any dels quals NO siga nul

SELECT nom, plataforma FROM jocs WHERE any IS NOT NULL;
