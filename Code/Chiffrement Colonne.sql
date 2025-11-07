-- Création de table
CREATE TABLE CarteCredits(
id UNIQUEIDENTIFIER DEFAULT newid(),
Nom NVARCHAR(50),
Numero VARBINARY(MAX)
)

-- Création de la master key (si non existante)
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD = '123ABCdef*';

-- Création du certificat pour le chiffrement colonne CB
CREATE CERTIFICATE Cert_CB
WITH SUBJECT = 'Certificat pour le chiffrement des CB';

-- Création de la clé symétrique
CREATE SYMMETRIC KEY KEY_Col_CB
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Cert_CB;


-- Dans les requetes

OPEN SYMMETRIC KEY KEY_Col_CB
DECRYPTION BY CERTIFICATE Cert_CB;

-- Exemple d'insertion d'une donnée chiffrée
INSERT INTO CarteCredits (Nom, Numero)
VALUES ('Dupont', 
	ENCRYPTBYKEY(
		KEY_GUID('KEY_Col_CB'), N'1345 5432 5678 7654'));




SELECT * FROM CarteCredits

SELECT nom, CONVERT(NVARCHAR,DECRYPTBYKEY(numero))
FROM CarteCredits


-- Fermer la clé
CLOSE SYMMETRIC KEY KEY_Col_CB;