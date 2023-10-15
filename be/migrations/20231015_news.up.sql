-- Add up migration script here

CREATE TABLE IF NOT EXISTS promotion(
    id UUID PRIMARY KEY,
    project_id UUID NOT NULL,
    account_id TEXT NOT NULL,
    rate DECIMAL(19,4) NOT NULL,
    status TEXT NOT NULL DEFAULT 'used',
    kind TEXT NOT NULL,
    create_dt TIMESTAMPTZ NOT NULL DEFAULT NOW()

);