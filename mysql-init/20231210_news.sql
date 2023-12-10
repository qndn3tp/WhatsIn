-- Add up migration script here

CREATE TABLE IF NOT EXISTS news(
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT,
    publishedAt TIMESTAMP NOT NULL,
    author TEXT
);