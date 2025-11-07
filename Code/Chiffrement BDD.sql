USE Master
Go 

-- Création de la master key
CREATE MASTER KEY 
ENCRYPTION BY PASSWORD ='123ABCdef*' 

-- Sauvegarde de la Master Key
BACKUP MASTER KEY TO 
    FILE = 'c:\Data DM\MasterKey'
    -- Chiffrement de la master key dans le fichier
    ENCRYPTION BY PASSWORD = '*defABC123'  

-- Restauration de Master key
RESTORE MASTER KEY   
    FROM FILE = 'c:\Data DM\MasterKey'   
    DECRYPTION BY PASSWORD = '*defABC123'   
    ENCRYPTION BY PASSWORD = '123ABCdef*'; 
    

USE Ventes
GO

-- Création de certificat pour la BDD
CREATE CERTIFICATE CertBDDVentes
    WITH SUBJECT = 'Chiffrement BDD Ventes';

BACKUP CERTIFICATE CertBDDVentes 
    TO FILE ='c:\data DM\CertBDDVentes'  
      WITH PRIVATE KEY   
      (   
        FILE ='c:\data DM\CertBDDVentesPrivateKey',  
        ENCRYPTION BY PASSWORD ='123ABCdef*'   
      )   


-- Clé de chiffrement pour la BDD
CREATE DATABASE ENCRYPTION KEY 
WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE CertBDDVentes;

-- Activation du chiffrement
ALTER DATABASE Ventes SET ENCRYPTION ON;

-- Chiffrement des sauvegardes
BACKUP DATABASE Ventes 
TO DISK = 'c:\Data DM\Backupventes.bak' 
WITH ENCRYPTION (ALGORITHM = AES_256, 
SERVER CERTIFICATE = CertBDDVentes);

