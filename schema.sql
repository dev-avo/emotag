-- emotag Database Schema
-- Cloudflare D1 (SQLite)

-- kaomoji 테이블
CREATE TABLE IF NOT EXISTS kaomoji (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contents TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    status INTEGER DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tag 테이블
CREATE TABLE IF NOT EXISTS tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- kaomoji_tag 테이블 (다대다 관계)
CREATE TABLE IF NOT EXISTS kaomoji_tag (
    kaomoji_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (kaomoji_id, tag_id),
    FOREIGN KEY (kaomoji_id) REFERENCES kaomoji(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE
);

-- 인덱스: 검색 성능 향상
CREATE INDEX IF NOT EXISTS idx_kaomoji_status ON kaomoji(status);
CREATE INDEX IF NOT EXISTS idx_tag_name ON tag(name);
CREATE INDEX IF NOT EXISTS idx_kaomoji_tag_kaomoji ON kaomoji_tag(kaomoji_id);
CREATE INDEX IF NOT EXISTS idx_kaomoji_tag_tag ON kaomoji_tag(tag_id);

