-- Original JWTs cannot be recovered from SHA-256 digests. Expire migrated
-- sessions instead of restoring or recreating plaintext credentials.
UPDATE user_sessions
SET session_status = 'EXPIRED',
    session_ended_at = NOW()
WHERE token ~ '^[0-9a-f]{64}$'
  AND session_status = 'ACTIVE';
