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
USING ( select distinct Date from Stage ) as st
ON mc.Date = st.Date
WHEN NOT MATCHED THEN
INSERT(Date)
VALUES(st.Date);
GO

