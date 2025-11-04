CREATE LOGIN [W10-SOCLE\Chefs Comptables] FROM WINDOWS WITH DEFAULT_DATABASE=[master]

-- 5) créer un BDD => tester l'UI pour plusieurs groupes de fichiers/ fichiers
CREATE DATABASE [Ventes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ventes1', FILENAME = N'C:\Data DM\e\Ventes1.mdf' , SIZE = 102400KB , FILEGROWTH = 0), 
FILEGROUP   [FG2] 
( NAME = N'Ventes2', FILENAME = N'C:\Data DM\g\Ventes2.ndf' , SIZE = 102400KB , FILEGROWTH = 0)
 LOG ON 
( NAME = N'Ventes_log', FILENAME = N'C:\Data DM\f\Ventes_log.ldf' , SIZE = 102400KB , FILEGROWTH = 0)



-- 6) ajouter l'accès au groupe (via login) pour lecture data dans la BDD
GO
USE Ventes
GO
CREATE SCHEMA Commercial
GO


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
