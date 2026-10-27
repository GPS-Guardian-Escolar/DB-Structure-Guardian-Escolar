-- Keep device-confirmation markers untouched; hash persisted JWTs before deploying
-- the backend that hashes incoming JWTs for logout lookup.
UPDATE user_sessions
SET token = encode(digest(token, 'sha256'), 'hex')
WHERE token ~ '^[A-Za-z0-9_-]+[.][A-Za-z0-9_-]+[.][A-Za-z0-9_-]+$';
