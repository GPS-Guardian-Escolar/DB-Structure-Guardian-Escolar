-- Do not restore the legacy password embedded in the previous seed changeset.
UPDATE users
SET is_active = false,
    updated_at = NOW()
WHERE id = '33333333-3333-3333-3333-333333333333';
