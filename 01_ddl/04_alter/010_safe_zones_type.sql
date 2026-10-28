ALTER TABLE safe_zones
    ADD COLUMN IF NOT EXISTS zone_type VARCHAR(20) NOT NULL DEFAULT 'Personalizado';
