/* CREATE TABLE [Stage] (
    [Podgrupa] varchar(100),
    [A16-49] varchar(100),
    [M16-49] varchar(100),
    [A4-15] varchar(100),
    [A4-9] varchar(100),
    [Date] varchar(100),
    [Channel] varchar(100),
    [Description] varchar(100),
    [Duration] varchar(100),
    [StartTime] varchar(100),
    [VariableTarget] varchar(100),
    [TotalIndividuals] varchar(100),
    [ndDescription] varchar(100),
) 
create table CleanStage(
       [MediaCalendarId] int
      ,[MediaTimeId] int
      ,[ProgrammeId] int
      ,[VariableTarget] varchar(50)
      ,[Podgrupa] numeric(16, 8)
      ,[A16-49] numeric(16, 8)
      ,[M16-49] numeric(16, 8)
      ,[A4-15] numeric(16, 8)
      ,[A4-9] numeric(16, 8)
      ,[TotalIndividuals] numeric(16, 8)
      )
*/

IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'MediaTime') 
   CREATE TABLE dbo.MediaTime (
     MediaTimeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
     Hour int,
     Minute int,
     Second int
   )
GO

IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'Programme') 
  CREATE TABLE dbo.Programme (
    ProgrammeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Channel varchar(100),
    Description varchar(100),
    ndDescription varchar(100),
    Duration int
  )
GO
  
IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'Group') 
  CREATE TABLE dbo.[Group](
    GroupId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GroupName varchar(30)
  )
GO

IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'MediaCalendar') 
  CREATE TABLE dbo.[Group](
    MediaCalendarId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Date date
  )
GO

IF NOT EXISTS (SELECT [name] FROM sys.tables WHERE [name] = 'Viewership') 
  CREATE TABLE dbo.[Viewership](
    ViewershipId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GroupId int FOREIGN KEY REFERENCES [Group](GroupId) ON DELETE CASCADE,
    ProgrammeId int FOREIGN KEY REFERENCES Programme(ProgrammeId) ON DELETE CASCADE,
    MediaCalendarId int FOREIGN KEY REFERENCES MediaCalendar(MediaCalendarId) ON DELETE CASCADE,
    MediaTimeId int FOREIGN KEY REFERENCES MediaTime(MediaTimeId) ON DELETE CASCADE,
    [AMR] numeric(16, 8),
    [AMR-perct] numeric(16, 8),
    [SHR-perct] numeric(16, 8),
    [RCH-perct] numeric(16, 8),
    [RCH] numeric(16, 8)
  )
GO