DECLARE @old_date varchar(100);
DECLARE @old_channel varchar(100);
DECLARE @old_desc varchar(100);
DECLARE @old_ndDesc varchar(100);
DECLARE @old_start varchar(100);
DECLARE @old_dur varchar(100);

UPDATE [dbo].[Stage] 
SET @old_date = Date = CASE WHEN len(Date)<1 THEN @old_date ELSE Date END,
	@old_channel = Channel= CASE WHEN len(Channel)<1 THEN @old_channel ELSE Channel END,
	@old_desc = Description = CASE WHEN len(Description)<1 THEN @old_desc ELSE Description END,
	@old_ndDesc = ndDescription = CASE WHEN len(ndDescription)<1 THEN @old_ndDesc ELSE ndDescription END,
	@old_start = StartTime = CASE WHEN len(StartTime)<1 THEN @old_start ELSE StartTime END,
	@old_dur = Duration = CASE WHEN len(Duration)<1 THEN @old_dur ELSE Duration END;
GO

INSERT INTO [dbo].[MediaTime] (Hour, Minute, Second)
  select distinct substring(StartTime, 1, 2), substring(StartTime, 4, 2), substring(StartTime, 7, 2) from Stage;
GO

INSERT INTO Programme (Channel, Description, ndDescription, Duration)
  select distinct Channel, Description, ndDescription, (datepart(hour, Duration) * 360) + (datepart(minute,Duration) * 60) + datepart(second,Duration)
  from Stage;
GO