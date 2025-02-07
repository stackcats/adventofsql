SELECT
    songs.song_title,
    COUNT(1)                                                   AS total_plays,
    COUNT(1) FILTER
        (WHERE songs.song_duration ISNULL
            OR COALESCE(up.duration, 0) < songs.song_duration) AS total_skips
FROM songs
         LEFT JOIN user_plays up ON up.song_id = songs.song_id
GROUP BY songs.song_id
ORDER BY total_plays DESC, total_skips;
