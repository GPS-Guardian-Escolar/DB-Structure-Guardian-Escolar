-- DML - CONTROLLED ADMINISTRATOR BOOTSTRAP
-- Executed only with the explicit bootstrap context.
-- Credentials must be injected by the deployment environment.

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
    gen_random_uuid(),
    'Administrador GPS Guardian Escolar',
    '${ADMIN_EMAIL}',
    '${ADMIN_PHONE}',
    '${ADMIN_PASSWORD_HASH}',
    true,
    true,
    NOW()
)
ON CONFLICT (email) DO UPDATE SET
    phone = EXCLUDED.phone,
    password_hash = EXCLUDED.password_hash,
    is_active = true,
    email_verified = true,
    updated_at = NOW();

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u
CROSS JOIN roles r
WHERE lower(u.email) = lower('${ADMIN_EMAIL}')
  AND r.role_name = 'ADMIN'
ON CONFLICT DO NOTHING;

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
WHERE lower(u.email) = lower('${ADMIN_EMAIL}')
  AND NOT EXISTS (
      SELECT 1 FROM notification_settings ns WHERE ns.user_id = u.id
  );
