ALTER TABLE students
    ADD COLUMN link_code_hash VARCHAR(100),
    ADD COLUMN link_code_expires_at TIMESTAMPTZ,
    ADD COLUMN link_code_used_at TIMESTAMPTZ,
    ADD COLUMN link_code_failed_attempts INTEGER NOT NULL DEFAULT 0;

ALTER TABLE students
    ADD CONSTRAINT students_link_code_failed_attempts_non_negative
    CHECK (link_code_failed_attempts >= 0);