DECLARE @old_date varchar(100);
DECLARE @old_channel varchar(100);
DECLARE @old_desc varchar(100);
DECLARE @old_ndDesc varchar(100);
DECLARE @old_start varchar(100);
DECLARE @old_dur varchar(100);

DECLARE @date varchar(100);
DECLARE @channel varchar(100);
DECLARE @desc varchar(100);
DECLARE @ndDesc varchar(100);
DECLARE @start varchar(100);
DECLARE @dur varchar(100);

DECLARE stage_cursor AS CURSOR;

SET @stage_cursor = CURSOR FOR 
SELECT Date, Channel, Description, ndDescription, StartTime, Duration FROM [dbo].[Stage]

OPEN stage_cursor;
FETCH NEXT FROM @stage_cursor INTO @old_date, @old_channel, @old_desc, @old_ndDesc, @old_start, @old_dur;
WHILE @@FETCH_STATUS = 0
BEGIN
 
  FETCH NEXT FROM @stage_cursor INTO @date, @channel, @desc, @ndDesc, @start, @dur;
  IF @date=NULL OR @date = ''
    UPDATE Stage set date=@old_date
  ELSE 
    SET @old_date = @date;
  
  IF @channel=NULL OR @channel = '' 
    UPDATE Stage set Date=@old_channel;
  ELSE 
    SET @old_channel = @channel;
  
  IF @desc=NULL OR @desc = '' 
    UPDATE Stage set Description=@old_desc;
  ELSE 
    SET @old_desc = @desc;
  
  IF @ndDesc=NULL OR @ndDesc = ''
    UPDATE Stage set ndDescription=@old_ndDesc;
  ELSE 
    SET @old_ndDesc = @ndDesc;
  
  IF @start=NULL OR @start = ''
    UPDATE Stage set StartTime=@old_start;
  ELSE 
    SET @old_start = @start;
  
  IF @dur=NULL OR @dur = ''
    UPDATE Stage set Duration=@old_dur;
  ELSE 
    SET @old_dur = @dur;    

END
CLOSE stage_cursor;  
DEALLOCATE stage_cursor;  