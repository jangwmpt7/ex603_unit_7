-- Drop indices.
DROP INDEX IF EXISTS idx_plays_user_played;
DROP INDEX IF EXISTS idx_plays_duration;

-- Find indices in the plays table.
SELECT indexname
FROM pg_indexes
WHERE tablename = 'plays';

-- Create indices for the fixed queries.
-- Composite index for Report A that has queries filter by user_id prior to played_at while covering track_id to speed up the joining process between plays and songs. 
CREATE INDEX idx_plays_user_played ON plays (user_id, played_at) INCLUDE (track_id);
ANALYZE plays (user_id, played_at, track_id);
ANALYZE songs (song_id, title);

-- Index for report B that covers user_id and play_duration_seconds to speed up the CTE that involves these attributes in the fixed queries.
CREATE INDEX idx_plays_duration ON plays (played_at) INCLUDE (user_id, play_duration_seconds);
ANALYZE accounts(account_id, name);
ANALYZE plays(user_id, play_duration_seconds);
