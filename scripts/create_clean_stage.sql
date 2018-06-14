INSERT INTO CleanStage(MediaCalendarId, MediaTimeId, ProgrammeId, VariableTarget, Podgrupa, [A16-49], [M16-49], [A4-15], [A4-9], [TotalIndividuals])
(SELECT 
	  MediaCalendarId
	  ,MediaTimeId
	  ,ProgrammeId
	  ,(CASE WHEN s.VariableTarget LIKE 'AMR %' THEN 'AMR-perct'
                             WHEN s.VariableTarget  LIKE 'SHR %' THEN 'SHR-perct'
                             WHEN len(s.VariableTarget )=30 THEN 'RCH-perct'
                             WHEN len(s.VariableTarget )=28  THEN 'RCH'
                             ELSE s.VariableTarget 
                         END) [VariableTarget]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([Podgrupa], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [Podgrupa]
      ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A16-49], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A16-49]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([M16-49], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [M16-49]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A4-15], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A4-15]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([A4-9], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [A4-9]
	  ,TRY_CONVERT(numeric(16, 8), REPLACE(REPLACE(REPLACE(REPLACE([TotalIndividuals], '%', ' '), ' ', '') , ',', '.'), ' ', '')) [TotalIndividuals]
  FROM [dbo].[Stage] s 
  JOIN MediaCalendar ON YEAR(s.Date) = MediaCalendar.Year AND MONTH(s.Date) = MediaCalendar.Day AND DAY(s.Date) = MediaCalendar.Month
  JOIN MediaTime ON CAST(substring(s.StartTime, 1, 2) as int) = MediaTime.Hour AND CAST(substring(StartTime, 4, 2) as int) = MediaTime.Minute 
		AND  Cast(substring(StartTime, 7, 2) as int) = MediaTime.Second
  JOIN Programme ON s.Description = Programme.Description AND s.ndDescription = Programme.ndDescription AND s.Channel = Programme.Channel
		AND (datepart(hour, s.Duration) * 360) + (datepart(minute,s.Duration) * 60) + datepart(second,s.Duration) = Programme.Duration
  );