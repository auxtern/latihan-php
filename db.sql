-- =========================
-- TABLE
-- =========================
CREATE TABLE IF NOT EXISTS todo (
    id SERIAL PRIMARY KEY,
    activity VARCHAR(250) NOT NULL,
    status SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- FUNCTION (REPLACE)
-- =========================
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- =========================
-- TRIGGER (SAFE RECREATE)
-- =========================
DROP TRIGGER IF EXISTS update_todo_timestamp ON todo;

CREATE TRIGGER update_todo_timestamp
BEFORE UPDATE ON todo
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
