INSERT INTO Viewership(GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
SELECT '4' AS GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH]
FROM
(SELECT ProgrammeId, MediaCalendarId, MediaTimeId, VariableTarget, [M16-49]
    FROM dbo.CleanStage) AS SourceTable
PIVOT
(
SUM([M16-49])
FOR VariableTarget IN ([AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
) AS PivotTable