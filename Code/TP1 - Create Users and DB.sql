-- xp_cmdshell : execution de commande dans le shell
-- => potentiellement dangereux => désactivé par défaut

exec xp_cmdshell 'dir c:'

-- utiliser sp_configure pour activer xp_cmdshell
-- pas dispo en UI

sp_configure 'show advanced options',0
reconfigure


sp_configure 'xp_cmdshell',1
reconfigure

-- utiliser powershell pour 
-- 1) créer un utilisateur (windows)
-- new-localUser -name "Paul Dupont"
-- 2) créer un groupe(windows)
-- new-localGroup "Chefs Comptables"
-- 3) Ajouter l'utilisateur au groupe 
-- Add-LocalGroupMember -Group "Chefs comptables" -Member "Paul Dupont"

-- Dans SQL
-- 4) créer un login pour le groupe
CREATE LOGIN [W10-SOCLE\Chefs Comptables] FROM WINDOWS WITH DEFAULT_DATABASE=[master]

-- 5) créer un BDD => tester l'UI pour plusieurs groupes de fichiers/ fichiers
CREATE DATABASE [Ventes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ventes1', FILENAME = N'C:\Data DM\e\Ventes1.mdf' , SIZE = 102400KB , FILEGROWTH = 0), 
 FILEGROUP [FG2] 
( NAME = N'Ventes2', FILENAME = N'C:\Data DM\g\Ventes2.ndf' , SIZE = 102400KB , FILEGROWTH = 0)
 LOG ON 
( NAME = N'Ventes_log', FILENAME = N'C:\Data DM\f\Ventes_log.ldf' , SIZE = 102400KB , FILEGROWTH = 65536KB )
 

-- 6) ajouter l'accès au groupe (via login) pour lecture data dans la BDD


CREATE SCHEMA Commercial
GO
-- DROP TABLE Commercial.Clients
CREATE TABLE Commercial.Clients
	(
	Id uniqueidentifier NULL,
	Nom nvarchar(50) NULL,
	Photo varbinary(MAX) NOT NULL,
	[Description] nvarchar(MAX) NULL
	)  
	ON [PRIMARY] -- données de taille définié
	TEXTIMAGE_ON FG2 -- données MAX

	-- Création du role de BDD
CREATE ROLE [Chefs comptables]
-- Authorisations sur Commercial
ALTER AUTHORIZATION ON SCHEMA::[Commercial] TO [Chefs comptables]
GRANT SELECT ON SCHEMA::[Commercial] TO [Chefs comptables] WITH GRANT OPTION 
GO

-- Création d'un user  ChefComptable_Socle dans la BDD
-- associé au groupe Windows des chefs comptables de SOCLE
CREATE USER ChefComptable_Socle FOR LOGIN [W10-SOCLE\Chefs Comptables]
-- Donner les droits via l'appartenance au role
ALTER ROLE [Chefs Comptables] 
ADD MEMBER ChefComptable_Socle
