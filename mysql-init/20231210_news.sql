-- Add up migration script here

CREATE TABLE IF NOT EXISTS news(
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT,
    published_at TIMESTAMP NOT NULL,
    author TEXT,
    url_to_article TEXT,
    url_to_image TEXT
);