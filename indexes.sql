-- Drop indices.
DROP INDEX IF EXISTS idx_plays_user_played;
DROP INDEX IF EXISTS idx_plays_duration;

-- Find indices in the plays table.
SELECT indexname
FROM pg_indexes
WHERE tablename = 'plays';

SELECT indexname
FROM pg_indexes
WHERE tablename = 'accounts';

-- Create indices for the fixed queries.
CREATE INDEX idx_plays_user_played ON plays (user_id, played_at) INCLUDE (track_id);    -- For Report A
ANALYZE plays (user_id, played_at, track_id);
ANALYZE songs (song_id, title);

CREATE INDEX idx_plays_duration ON plays (played_at) INCLUDE (user_id, play_duration_seconds);  -- For Report B
ANALYZE accounts(account_id, name);
ANALYZE plays(user_id, play_duration_seconds);