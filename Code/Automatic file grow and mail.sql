-- Je veux recevoir un mail
-- Augmenter la taille des fichiers de données
-- si les fichiers de données sont pleins à 80%

-- strategie
-- alert => compteur database / database file
--			=> augmentation taille du ficher
--			=> mail operator en cas de succes
--          => mail opérator error

DECLARE @Files Table(
    Nom NVARCHAR(1000)) -- Variable de type table
INSERT INTO @Files
SELECT
    name AS [NomFichier]
   
FROM sys.database_files
WHERE type_desc = 'ROWS' AND 
CAST(FILEPROPERTY(name, 'SpaceUsed') * 100.0 / size AS DECIMAL(5,2)) >40
-- Seulement les fichiers de données (.mdf)

SELECT * FROM @Files
DECLARE moncurseur CURSOR FOR SELECT * FROM @Files
DECLARE @FileNAme AS NVARCHAR(1000)
OPEN moncurseur
FETCH NEXT FROM moncurseur INTO @FileNAme
WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @FileSize INT =FILEPROPERTY(@FileName, 'SpaceUsed')*1.2
    -- Grossissement du fichier
    DECLARE @Commande NVARCHAR(1000) = 'ALTER DATABASE Ventes MODIFY FILE (NAME = '
        + @FileName+', SIZE = '
        +CONVERT(NVARCHAR,@FileSize)+')';
    BEGIN TRY
    EXEC sp_executesql @Commande 

    Print 'Send mail to opérator => Taille de fichier aumenté'
    END TRY
    BEGIN CATCH
        Print 'Send mail to opérator => disque plein'
    END CATCH

    FETCH NEXT FROM moncurseur INTO @FileNAme
END

DEALLOCATE moncurseur