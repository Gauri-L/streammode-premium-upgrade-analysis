-- StreamMODE capstone | Streaming session data validation
-- SQL Server and SSMS. The database and imported table must already exist.
-- Reported capstone results: 14,000 rows and 14 columns. No SQL NULLs,
-- duplicate SessionIDs, negative values in the four checked fields, or rows
-- with positive playback minutes when PlaybackStarted = 0.
-- 213 sessions where playback did not start were retained in the dataset.

USE StreamMODE_Project;
GO

-- 1. Count imported records.
SELECT COUNT(*) AS TotalRows
FROM dbo.Streaming_Sessions;

-- 2. Review column names and data types in import order.
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Streaming_Sessions'
ORDER BY ORDINAL_POSITION;

-- 3. Count SQL NULLs in all 14 columns.
SELECT
    COUNT(CASE WHEN SessionID IS NULL THEN 1 END) AS MissingSessionID,
    COUNT(CASE WHEN UserID IS NULL THEN 1 END) AS MissingUserID,
    COUNT(CASE WHEN MovieID IS NULL THEN 1 END) AS MissingMovieID,
    COUNT(CASE WHEN SessionStartUTC IS NULL THEN 1 END) AS MissingSessionStartUTC,
    COUNT(CASE WHEN DeviceType IS NULL THEN 1 END) AS MissingDeviceType,
    COUNT(CASE WHEN PlaybackMinutes IS NULL THEN 1 END) AS MissingPlaybackMinutes,
    COUNT(CASE WHEN Country IS NULL THEN 1 END) AS MissingCountry,
    COUNT(CASE WHEN PlaybackStarted IS NULL THEN 1 END) AS MissingPlaybackStarted,
    COUNT(CASE WHEN BufferingSeconds IS NULL THEN 1 END) AS MissingBufferingSeconds,
    COUNT(CASE WHEN StartupTimeSeconds IS NULL THEN 1 END) AS MissingStartupTimeSeconds,
    COUNT(CASE WHEN PlaybackErrorFlag IS NULL THEN 1 END) AS MissingPlaybackErrorFlag,
    COUNT(CASE WHEN DataTransferredGB IS NULL THEN 1 END) AS MissingDataTransferredGB,
    COUNT(CASE WHEN State IS NULL THEN 1 END) AS MissingState,
    COUNT(CASE WHEN ResolutionDelivered IS NULL THEN 1 END) AS MissingResolutionDelivered
FROM dbo.Streaming_Sessions;

-- 4. List session IDs that appear more than once.
SELECT
    SessionID,
    COUNT(*) AS SessionCount
FROM dbo.Streaming_Sessions
GROUP BY SessionID
HAVING COUNT(*) > 1;

-- 5. Review the distribution of playback start and error flags.
SELECT
    PlaybackStarted,
    COUNT(*) AS TotalSessions
FROM dbo.Streaming_Sessions
GROUP BY PlaybackStarted
ORDER BY PlaybackStarted;

SELECT
    PlaybackErrorFlag,
    COUNT(*) AS TotalSessions
FROM dbo.Streaming_Sessions
GROUP BY PlaybackErrorFlag
ORDER BY PlaybackErrorFlag;

-- 6. Review the earliest and latest session timestamps (UTC).
SELECT
    MIN(SessionStartUTC) AS FirstSessionUTC,
    MAX(SessionStartUTC) AS LastSessionUTC
FROM dbo.Streaming_Sessions;

-- 7. Count negative values in duration and data-transfer fields.
SELECT
    COUNT(CASE WHEN PlaybackMinutes < 0 THEN 1 END) AS NegativePlaybackMinutes,
    COUNT(CASE WHEN BufferingSeconds < 0 THEN 1 END) AS NegativeBufferingSeconds,
    COUNT(CASE WHEN StartupTimeSeconds < 0 THEN 1 END) AS NegativeStartupTimeSeconds,
    COUNT(CASE WHEN DataTransferredGB < 0 THEN 1 END) AS NegativeDataTransferredGB
FROM dbo.Streaming_Sessions;

-- 8. Flag positive playback minutes when the start flag is off.
SELECT
    SessionID,
    PlaybackStarted,
    PlaybackMinutes,
    PlaybackErrorFlag
FROM dbo.Streaming_Sessions
WHERE PlaybackStarted = 0
  AND PlaybackMinutes > 0;

-- 9. Review device, country and state labels and their frequencies.
SELECT
    DeviceType,
    COUNT(*) AS TotalSessions
FROM dbo.Streaming_Sessions
GROUP BY DeviceType
ORDER BY TotalSessions DESC, DeviceType;

SELECT
    Country,
    COUNT(*) AS TotalSessions
FROM dbo.Streaming_Sessions
GROUP BY Country
ORDER BY TotalSessions DESC, Country;

SELECT
    State,
    COUNT(*) AS TotalSessions
FROM dbo.Streaming_Sessions
GROUP BY State
ORDER BY TotalSessions DESC, State;
