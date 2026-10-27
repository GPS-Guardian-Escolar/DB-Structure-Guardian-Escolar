ALTER TABLE routes
    ADD COLUMN IF NOT EXISTS origin_address VARCHAR(255),
    ADD COLUMN IF NOT EXISTS destination_address VARCHAR(255);
