ALTER TABLE users DROP CONSTRAINT IF EXISTS ck_users_email_format;
ALTER TABLE users
    ADD CONSTRAINT ck_users_email_format
    CHECK (email ~* '^[a-z0-9](?:[a-z0-9._%+-]{0,62}[a-z0-9])?@(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,24}$');

UPDATE users SET two_factor_method = 'EMAIL' WHERE two_factor_method IS NULL OR two_factor_method <> 'EMAIL';
ALTER TABLE users DROP CONSTRAINT IF EXISTS users_two_factor_method_check;
ALTER TABLE users
    ADD CONSTRAINT users_two_factor_method_check CHECK (two_factor_method = 'EMAIL');
