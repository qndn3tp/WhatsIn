-- Add up migration script here

CREATE TABLE IF NOT EXISTS news(
    id UUID PRIMARY KEY,
    create_dt TIMESTAMPTZ NOT NULL DEFAULT NOW()
);