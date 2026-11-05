ALTER TABLE student_routes
    ADD COLUMN is_preferred BOOLEAN NOT NULL DEFAULT FALSE;

WITH ranked_routes AS (
    SELECT student_id, route_id,
           ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY assigned_at NULLS LAST, route_id) AS position
    FROM student_routes
    WHERE is_active IS TRUE
)
UPDATE student_routes sr
SET is_preferred = TRUE
FROM ranked_routes rr
WHERE rr.student_id = sr.student_id
  AND rr.route_id = sr.route_id
  AND rr.position = 1;

CREATE UNIQUE INDEX uq_student_routes_preferred_active
    ON student_routes (student_id)
    WHERE is_active IS TRUE AND is_preferred IS TRUE;
