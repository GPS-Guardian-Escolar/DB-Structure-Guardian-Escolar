-- =============================================
-- DML - SYSTEM ADMIN USER
-- Required administrator account for local/demo deployments only.
-- Values must be supplied by Liquibase variables, never committed to Git.
-- =============================================

INSERT INTO users (
    id,
    full_name,
    email,
    phone,
    password_hash,
    is_active,
    email_verified,
    created_at
)
VALUES (
    '${ADMIN_USER_ID}',
    'Administrador GPS Guardian Escolar',
    '${ADMIN_EMAIL}',
    '${ADMIN_PHONE}',
    '${ADMIN_PASSWORD_HASH}',
    true,
    true,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    email = EXCLUDED.email,
    phone = EXCLUDED.phone,
    password_hash = EXCLUDED.password_hash,
    is_active = true,
    email_verified = true,
    updated_at = NOW();

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u
CROSS JOIN roles r
WHERE u.email = '${ADMIN_EMAIL}'
  AND r.role_name = 'ADMIN'
ON CONFLICT DO NOTHING;

UPDATE notification_settings cn
SET delay_alert = true,
    route_change_alert = true,
    arrival_alert = true,
    inactivity_alert = true,
    email_channel = true,
    updated_at = NOW()
FROM users u
WHERE cn.user_id = u.id
  AND u.email = '${ADMIN_EMAIL}';

INSERT INTO notification_settings (
    user_id,
    delay_alert,
    route_change_alert,
    arrival_alert,
    inactivity_alert,
    email_channel
)
SELECT u.id, true, true, true, true, true
FROM users u
WHERE u.email = '${ADMIN_EMAIL}'
  AND NOT EXISTS (
      SELECT 1 FROM notification_settings cn WHERE cn.user_id = u.id
  );
