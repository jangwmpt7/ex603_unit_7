-- This query is faster given the index that is defined for Report A alongside analyzing the tables involved in that report.
SELECT p.played_at, s.title
FROM   plays p
JOIN   songs s ON s.song_id = p.track_id
WHERE  p.user_id = 1
ORDER  BY p.played_at DESC
LIMIT  50;
