CREATE OR REPLACE FUNCTION fn_purge_completed_trip_coordinates(p_before TIMESTAMPTZ)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE
    v_deleted BIGINT;
BEGIN
    IF p_before IS NULL THEN
        RAISE EXCEPTION 'A retention cutoff timestamp is required';
    END IF;

    DELETE FROM coordinates c
    USING trips t
    WHERE c.trip_id = t.id
      AND t.status IN ('COMPLETED', 'CANCELED')
      AND t.trip_ended_at IS NOT NULL
      AND t.trip_ended_at < p_before;

    GET DIAGNOSTICS v_deleted = ROW_COUNT;
    RETURN v_deleted;
END;
$$;
