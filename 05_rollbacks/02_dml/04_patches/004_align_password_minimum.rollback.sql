UPDATE password_policies
SET min_length = 10,
    updated_at = NOW()
WHERE min_length = 8;
