ALTER TABLE students
    DROP CONSTRAINT IF EXISTS students_link_code_failed_attempts_non_negative;

ALTER TABLE students
    DROP COLUMN IF EXISTS link_code_hash,
    DROP COLUMN IF EXISTS link_code_expires_at,
    DROP COLUMN IF EXISTS link_code_used_at,
    DROP COLUMN IF EXISTS link_code_failed_attempts;