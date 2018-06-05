INSERT INTO Viewership(GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
SELECT '2' AS GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH]
FROM
(SELECT ProgrammeId, MediaCalendarId, MediaTimeId, VariableTarget, [Podgrupa]
    FROM dbo.CleanStage) AS SourceTable
PIVOT
(
SUM([Podgrupa])
FOR VariableTarget IN ([AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
) AS PivotTable