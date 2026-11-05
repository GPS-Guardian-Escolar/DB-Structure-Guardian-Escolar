DROP INDEX IF EXISTS uq_student_routes_preferred_active;
ALTER TABLE student_routes DROP COLUMN IF EXISTS is_preferred;
