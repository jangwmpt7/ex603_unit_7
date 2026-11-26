-- This query is faster than the unfixed one, replacing BETWEEN with a SARGable counterpart and uses a CTE to calculate and aggregate results before joining, not just the index of played_at that covers user_id and play_duration_seconds.
WITH dec_2025_totals AS (
    SELECT user_id, ROUND(SUM(play_duration_seconds) / 60.0, 1) AS minutes
    FROM plays
    WHERE played_at >= '2025-12-01' AND played_at < '2026-01-01'
    GROUP BY user_id
)
SELECT a.account_id, a.name, dt.minutes
FROM   dec_2025_totals dt
JOIN   accounts a ON a.account_id = dt.user_id
ORDER  BY minutes DESC NULLS LAST, a.account_id
LIMIT  20;
