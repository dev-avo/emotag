-- emotag 초기 시드 데이터
-- 기본 카오모지와 태그를 삽입합니다

-- 비밀번호는 'demo1234'를 SHA-256 해시한 값
-- 실제 운영에서는 사용하지 마세요!

-- Kaomoji 삽입
INSERT INTO kaomoji (contents, password, status) VALUES
('(◕‿◕)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(´･ω･`)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(╯°□°)╯︵ ┻━┻', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('┬─┬ノ( º _ ºノ)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(ノ´ヮ`)ノ*: ・゚✧', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(づ｡◕‿‿◕｡)づ', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(ಥ﹏ಥ)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(◠‿◠)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('¯\_(ツ)_/¯', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(•_•) ( •_•)>⌐■-■ (⌐■_■)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('ʕ•ᴥ•ʔ', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(｡◕‿◕｡)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(ʘ‿ʘ)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('( ͡° ͜ʖ ͡°)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1),
('(╥﹏╥)', '937e8d5fbb48bd4949536cd65b8d35c426b80d2f830c5c308e2cdec422ae2244', 1);

-- 태그 삽입
INSERT INTO tag (name) VALUES
('happy'),
('sad'),
('cute'),
('angry'),
('love'),
('funny'),
('cool'),
('shrug'),
('bear'),
('sparkle'),
('cry'),
('hug'),
('flip'),
('calm');

-- Kaomoji-Tag 연결
-- (◕‿◕) - happy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (1, 1), (1, 3);

-- (´･ω･`) - cute, sad
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (2, 3), (2, 2);

-- (╯°□°)╯︵ ┻━┻ - angry, flip
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (3, 4), (3, 13);

-- ┬─┬ノ( º _ ºノ) - calm
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (4, 14);

-- (ノ´ヮ`)ノ*: ・゚✧ - happy, sparkle
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (5, 1), (5, 10);

-- (づ｡◕‿‿◕｡)づ - hug, love, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (6, 12), (6, 5), (6, 3);

-- (ಥ﹏ಥ) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (7, 2), (7, 11);

-- (◠‿◠) - happy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (8, 1), (8, 3);

-- ¯\_(ツ)_/¯ - shrug, funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (9, 8), (9, 6);

-- (•_•) ( •_•)>⌐■-■ (⌐■_■) - cool, funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (10, 7), (10, 6);

-- ʕ•ᴥ•ʔ - bear, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (11, 9), (11, 3);

-- (｡◕‿◕｡) - happy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (12, 1), (12, 3);

-- (ʘ‿ʘ) - happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (13, 1);

-- ( ͡° ͜ʖ ͡°) - funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (14, 6);

-- (╥﹏╥) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (15, 2), (15, 11);

