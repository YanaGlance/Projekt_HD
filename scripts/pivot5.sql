INSERT INTO Viewership(GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
SELECT '5' AS GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH]
FROM
(SELECT ProgrammeId, MediaCalendarId, MediaTimeId, VariableTarget, [A4-15]
    FROM dbo.CleanStage) AS SourceTable
PIVOT
(
SUM([A4-15])
FOR VariableTarget IN ([AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
) AS PivotTable