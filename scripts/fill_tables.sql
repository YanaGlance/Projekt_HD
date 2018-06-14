MERGE [dbo].[MediaTime] AS mt 
USING ( select distinct substring(StartTime, 1, 2) as Hour, substring(StartTime, 4, 2) as Minute, substring(StartTime, 7, 2) as Second from Stage ) as st
ON mt.Hour = st.Hour AND mt.Minute = st.Minute AND mt.Second = st.Second
WHEN NOT MATCHED THEN
INSERT(Hour, Minute, Second)
VALUES(st.Hour, st.Minute, st.Second);
GO

MERGE Programme AS pro 
USING ( select distinct Channel, Description, ndDescription, (datepart(hour, Duration) * 360) + (datepart(minute,Duration) * 60) + datepart(second,Duration) as Duration from Stage ) as st
ON pro.Channel = st.Channel AND pro.ndDescription = st.ndDescription AND pro.Duration = st.Duration
WHEN NOT MATCHED THEN
INSERT(Channel, Description, ndDescription, Duration)
VALUES(st.Channel, st.Description, st.ndDescription, st.Duration);
GO


MERGE MediaCalendar AS mc 
USING ( select distinct YEAR(Date) as Year, MONTH(Date) as Month, DAY(Date) as Day from Stage ) as st
ON mc.Year = st.Year AND mc.Month = st.Month AND mc.Day = st.Day
WHEN NOT MATCHED THEN
INSERT(Year, Month, Day)
VALUES(st.Year, st.Day, st.Month);
GO

--MediaGroup--
MERGE Programme AS pro 
USING ( select distinct Channel, MediaGroup from ProgrammeTmp p JOIN MediaGroup m ON p.MediaGroup = m.GroupName) as st
ON pro.Channel=st.Channel
WHEN MATCHED THEN
UPDATE SET pro. MediaGroup = st.MediaGroup;
GO
