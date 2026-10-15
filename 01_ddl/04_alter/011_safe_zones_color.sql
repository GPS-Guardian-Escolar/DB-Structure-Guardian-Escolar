ALTER TABLE safe_zones
    ADD COLUMN IF NOT EXISTS color VARCHAR(20) NOT NULL DEFAULT '#EF4444';

UPDATE safe_zones
SET color = CASE zone_type
    WHEN 'Casa' THEN '#84CC16'
    WHEN 'Escuela' THEN '#60A5FA'
    ELSE '#EF4444'
END
WHERE color IS NULL OR BTRIM(color) = '' OR color = '#EF4444';
