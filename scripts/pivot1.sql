INSERT INTO Viewership(GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
SELECT '1' AS GroupId, ProgrammeId, MediaCalendarId, MediaTimeId, [AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH]
FROM
(SELECT ProgrammeId, MediaCalendarId, MediaTimeId, VariableTarget, TotalIndividuals
    FROM dbo.CleanStage) AS SourceTable
PIVOT
(
SUM(TotalIndividuals)
FOR VariableTarget IN ([AMR], [AMR-perct], [SHR-perct], [RCH-perct], [RCH])
) AS PivotTable