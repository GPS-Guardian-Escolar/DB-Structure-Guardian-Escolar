ALTER TABLE safe_zones ADD COLUMN IF NOT EXISTS address VARCHAR(160);
UPDATE safe_zones SET address = LEFT(latitude::text || chr(44) || chr(32) || longitude::text, 160) WHERE address IS NULL OR BTRIM(address) = '';
