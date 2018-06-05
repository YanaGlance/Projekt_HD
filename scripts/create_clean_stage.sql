truncate CleanStage;

INSERT INTO CleanStage(MediaCalendarId, MediaTimeId, ProgrammeId, VariableTarget, Podgrupa, [A16-49], [M16-49], [A4-15], [A4-9], [TotalIndividuals])
(SELECT 
	  MediaCalendarId
	  ,MediaTimeId
	  ,ProgrammeId
	  ,(CASE WHEN Stage.VariableTarget LIKE 'AMR %' THEN 'AMR-perct'
                             WHEN Stage.VariableTarget  LIKE 'SHR %' THEN 'SHR-perct'
                             WHEN len(Stage.VariableTarget )=30 THEN 'RCH-perct'
                             WHEN len(Stage.VariableTarget )=28  THEN 'RCH'
                             ELSE Stage.VariableTarget 
                         END) [VariableTarget]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([Podgrupa], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [Podgrupa]
      ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A16-49], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A16-49]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([M16-49], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [M16-49]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A4-15], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A4-15]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A4-9], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A4-9]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([TotalIndividuals], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [TotalIndividuals]
  FROM [dbo].[Stage] 
  JOIN MediaCalendar ON Cast(Stage.Date as date) = MediaCalendar.Date
  JOIN MediaTime ON CAST(substring(Stage.StartTime, 1, 2) as int) = MediaTime.Hour AND CAST(substring(StartTime, 4, 2) as int) = MediaTime.Minute 
		AND  Cast(substring(StartTime, 7, 2) as int) = MediaTime.Second
  JOIN Programme ON Stage.Description = Programme.Description AND Stage.ndDescription = Programme.ndDescription AND Stage.Channel = Programme.Channel
		AND (datepart(hour, Stage.Duration) * 360) + (datepart(minute,Stage.Duration) * 60) + datepart(second,Stage.Duration) = Programme.Duration
  );