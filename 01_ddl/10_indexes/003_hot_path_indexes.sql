-- Índices para lecturas frecuentes de notificaciones y tracking.
CREATE INDEX IF NOT EXISTS idx_notification_receipts_user
    ON notification_receipts(user_id);

CREATE INDEX IF NOT EXISTS idx_notifications_safe_zone
    ON notifications(safe_zone_id);

CREATE INDEX IF NOT EXISTS idx_coordinates_trip_recorded_at
    ON coordinates(trip_id, recorded_at);
