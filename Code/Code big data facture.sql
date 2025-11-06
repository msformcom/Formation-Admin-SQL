CREATE SCHEMA Ventes
GO

CREATE TABLE Ventes.Factures(
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT newid(),
	Date DATE NOT NULL,
	Numero UNIQUEIDENTIFIER  DEFAULT newid(),
	Data UNIQUEIDENTIFIER  DEFAULT newid()
	)
GO
INSERT INTO Ventes.Factures(Date)
VALUES(DATEADD(year,-12,GETDATE()))

-- Insertion de données 
DECLARE @anciennete INT =-11
WHILE @anciennete<=0
BEGIN
	INSERT INTO Ventes.Factures(Date)
	SELECT DATEADD(year, @anciennete,GETDATE())
	FROM Ventes.Factures
	SET @anciennete=@anciennete+1
END

-- Insertion de données 
DECLARE @anciennete INT =-5
WHILE @anciennete<=0
BEGIN
	INSERT INTO Ventes.Factures(Date)
	SELECT DATEADD(year, @anciennete,GETDATE())
	FROM Ventes.Factures
	SET @anciennete=@anciennete+1
END