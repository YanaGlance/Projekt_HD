INSERT INTO Viewership(GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
SELECT '6' AS GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH]
FROM
(SELECT ProgrammeId, MediaCalendarId, MediaTimeId, VariableTarget, [A4-9]
    FROM dbo.CleanStage) AS SourceTable
PIVOT
(
SUM([A4-9])
FOR VariableTarget IN ([AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
) AS PivotTable;