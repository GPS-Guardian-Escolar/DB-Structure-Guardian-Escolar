ALTER TABLE users DROP CONSTRAINT IF EXISTS users_two_factor_method_check;
ALTER TABLE users
    ADD CONSTRAINT users_two_factor_method_check CHECK (two_factor_method IN ('EMAIL', 'SMS'));

ALTER TABLE users DROP CONSTRAINT IF EXISTS ck_users_email_format;
ALTER TABLE users
    ADD CONSTRAINT ck_users_email_format
    CHECK (email ~* '^[a-z0-9](?:[a-z0-9._%+-]{0,62}[a-z0-9])?@(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+(com|co|edu|org|net|gov|mil|info|io|app|dev|es)$');
