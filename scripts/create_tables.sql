IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = MyTable) 
   CREATE TABLE dbo.MediaTime (
     MediaTimeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
     Hour int,
     Minute int,
     Second int
   )
GO

IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = Programme) 
  CREATE TABLE dbo.Programme (
    ProgrammeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Channel varchar(70),
    Description varchar(70),
    ndDescription varchar(70),
    Duration int
  )
GO
  
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = [Group]) 
  CREATE TABLE dbo.[Group](
    GroupId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GroupName varchar(30)
  )
GO