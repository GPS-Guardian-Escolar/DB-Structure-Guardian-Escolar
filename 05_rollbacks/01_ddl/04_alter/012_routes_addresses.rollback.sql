ALTER TABLE routes
    DROP COLUMN IF EXISTS origin_address,
    DROP COLUMN IF EXISTS destination_address;
