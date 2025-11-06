-- Créer un travail à exécuter 
-- régulièrement pour vérifier les stratégies non valides
-- 
DECLARE @Messages NVARCHAR(MAX) = '';
SELECT @Messages = @Messages+ s.name + ' ' 
        + FORMAT(d.execution_date,'yyyy-MM-dd HH:mm') + ' '
        +d.target_query_expression + CHAR(10) + CHAR(13)
FROM msdb.dbo.syspolicy_policy_execution_history AS h
JOIN msdb.dbo.syspolicy_policy_execution_history_details AS d ON d.history_id = h.history_id
JOIN msdb.dbo.syspolicy_policies s ON s.policy_id=h.policy_id
WHERE h.start_date > DATEADD(MINUTE,-60, GETDATE())  -- fenêtre récente
  AND d.result = 0
  --AND s.name='Nom stratégie'
  ;                                       -- non conforme

-- 3) Déclenchement conditionnel
IF LEN(@Messages) > 0
BEGIN
    PRINT @Messages
    --EXECUTE msdb.dbo.sp_send_dbmail
    --@profile_name = 'Adventure Works Administrator',
    --@recipients = 'yourfriend@adventure-works.com',
    --@body = 'The stored procedure finished successfully.',
    --@subject = 'Automated Success Message';

    --EXEC msdb.dbo.sp_start_job @job_name = N'TonJobDeRemédiation';

    --RAISERROR(15000,16,1) WITH LOG

    EXECUTE msdb.dbo.sp_notify_operator
    @profile_name = N'Mail de mon entreprise',
    @name = N'Admin BDD Ventes',
    @subject = N'Stratégie non validée',
    @body = @messages;

END;