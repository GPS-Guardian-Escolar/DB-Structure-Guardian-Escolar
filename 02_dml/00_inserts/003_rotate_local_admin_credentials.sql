UPDATE users
SET email = '${ADMIN_EMAIL}',
    phone = '${ADMIN_PHONE}',
    password_hash = '${ADMIN_PASSWORD_HASH}',
    updated_at = NOW()
WHERE id = '33333333-3333-3333-3333-333333333333';
