

-- Sélectionner les sessions qui bloquent d'autres sessions depuis plus de 10 secondes

    SELECT
        r.blocking_session_id AS blocking_session_id,
        r.wait_time,
        r.wait_type,
        r.sql_handle,
        t.text AS query_text
         INTO #BlockingSessions
    FROM 
        sys.dm_exec_requests r
    JOIN 
        sys.dm_exec_sessions s ON r.session_id = s.session_id
    CROSS APPLY 
        sys.dm_exec_sql_text(r.sql_handle) t
    WHERE 
        r.blocking_session_id <> 0  -- Sessions bloquantes (celles qui ont un blocking_session_id)
        AND r.wait_time > 10000    -- Verrouillage depuis plus de 10 secondes (10 000 ms)


-- Tuer les sessions bloquantes
DECLARE @blocking_session_id INT
DECLARE @sql NVARCHAR(50)
DECLARE blocking_cursor CURSOR FOR
SELECT blocking_session_id
FROM #BlockingSessions;

OPEN blocking_cursor;
FETCH NEXT FROM blocking_cursor INTO @blocking_session_id;

-- Boucle pour tuer chaque session bloquante
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql='KILL '+CONVERT(NVARCHAR,@blocking_session_id)
    -- Tuer la session bloquante
    -- sp_executesql 
    exec sp_executesql @sql
   

    FETCH NEXT FROM blocking_cursor INTO @blocking_session_id;
END;

CLOSE blocking_cursor;
DEALLOCATE blocking_cursor;

DROP TABLE #BlockingSessions