-- Complete -- Differential -- Log
--DECLARE @type NVARCHAR(1000)='Complete' 
--DECLARE @type NVARCHAR(1000)='Differential' 
--DECLARE @type NVARCHAR(1000)='FG2'
DECLARE @type NVARCHAR(1000)='LastLog' 
-- DECLARE @type NVARCHAR(1000)='Primary' 
--DECLARE @type NVARCHAR(1000)='Log' 
DECLARE @Path NVARCHAR(1000)=N'C:\Data DM\k';
DECLARE @Database NVARCHAR(1000)=N'Ventes';
DECLARE @TimeStamp NVARCHAR(1000)= FORMAT(GETDATE(),'yyyyMMddHHmmss')
DECLARE @filePath NVARCHAR(1000)=@Path+'\'+@Database+'-'+@type+'-'+@timestamp+ '.bak'
-- Sauvegarde complète 
IF @type='Complete'
BEGIN
	BACKUP DATABASE [Ventes] 
	TO  DISK = @FilePath 
END

-- Sauvegarde Differenielle
IF @type='Differential'
BEGIN
	BACKUP DATABASE [Ventes] TO  
	DISK = @FilePath 
	WITH  DIFFERENTIAL
END

-- Sauvegarde Log
IF @type='Log'
BEGIN
	BACKUP LOG [Ventes] TO  
	DISK = @FilePath 
END

IF @Type='FG2'
BEGIN
	BACKUP DATABASE [Ventes] 
	FILEGROUP = N'FG2' 
	TO  DISK = @FilePath 
END

IF @Type='Primary'
BEGIN
	BACKUP DATABASE [Ventes] 
	FILEGROUP = N'Primary' 
	TO  DISK = @FilePath 
END

IF @type='LastLog'
BEGIN 
	BACKUP LOG [Ventes] TO  
	DISK = @FilePath 
	WITH CONTINUE_AFTER_ERROR
END

SELECT @filePath