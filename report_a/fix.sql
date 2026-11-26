-- Analyze these two tables and their attributes involved in the query below.
ANALYZE plays (user_id, played_at, track_id);
ANALYZE songs (song_id, title);

-- This query is now far faster, using a composite index of user_id and played_at that also includes track_id.
SELECT s.song_id, s.title, COUNT(played_at) AS play_count
FROM   plays p
JOIN   songs s ON s.song_id = p.track_id
WHERE  p.user_id = 1
  AND  p.played_at >= '2025-01-01'
  AND  p.played_at <  '2026-01-01'
GROUP  BY s.song_id, s.title
ORDER  BY play_count DESC, s.song_id
LIMIT  20;
