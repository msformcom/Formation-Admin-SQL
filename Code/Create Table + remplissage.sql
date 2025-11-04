CREATE SCHEMA Commercial
GO
-- DROP TABLE Commercial.Clients
CREATE TABLE Commercial.Clients
	(
	Id uniqueidentifier PRIMARY KEY DEFAULT newid(),
	Nom nvarchar(50) NULL,
	Photo varbinary(MAX) NULL,
	[Description] nvarchar(MAX) NULL
	)  
	ON [PRIMARY] -- données de taille définié
	TEXTIMAGE_ON FG2 -- données MAX
GO
INSERT INTO Commercial.clients(Nom,description)
VALUES ('a','IOUOIUOUI')

INSERT INTO Commercial.clients(Nom,description)
SELECT 'E'+nom,'fsdfsd'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'z'+nom,'fqsfsdff'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'r'+nom,'qsdsvdfsgb dfdfg'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'l'+nom,'fazef'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'm'+nom,'fzefsqdf'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'v'+nom,'grgerg '+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'y'+nom,'gree rgerg'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'j'+nom,'qdqd dqsd'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'r'+nom,'qdqsdf ddqsd'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'E'+nom,'fsdfsd'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'z'+nom,'fqsfsdff'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'r'+nom,'qsdsvdfsgb dfdfg'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'l'+nom,'fazef'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'm'+nom,'fzefsqdf'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'v'+nom,'grgerg '+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'y'+nom,'gree rgerg'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'j'+nom,'qdqd dqsd'+description FROM Commercial.clients

INSERT INTO Commercial.clients(Nom,description)
SELECT 'r'+nom,'qdqsdf ddqsd'+description FROM Commercial.clients