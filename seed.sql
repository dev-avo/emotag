-- emotag 초기 시드 데이터
-- 기본 카오모지와 태그를 삽입합니다

-- 비밀번호는 'demo1234'를 SHA-256 해시한 값
-- 실제 운영에서는 사용하지 마세요!

-- Kaomoji 삽입
INSERT INTO kaomoji (contents, password, status) VALUES
('(◕‿◕)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´･ω･`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(╯°□°)╯︵ ┻━┻', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('┬─┬ノ( º _ ºノ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ノ´ヮ`)ノ*: ・゚✧', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(づ｡◕‿‿◕｡)づ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ಥ﹏ಥ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◠‿◠)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('¯\_(ツ)_/¯', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(•_•) ( •_•)>⌐■-■ (⌐■_■)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ʕ•ᴥ•ʔ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(｡◕‿◕｡)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ʘ‿ʘ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ͡° ͜ʖ ͡°)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(╥﹏╥)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1);

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

-- ========================================
-- 추가 카오모지 100개 (ID 16-115)
-- ========================================

-- 추가 태그 삽입
INSERT INTO tag (name) VALUES
('excited'),      -- 15
('sleepy'),       -- 16
('confused'),     -- 17
('surprised'),    -- 18
('wink'),         -- 19
('dance'),        -- 20
('music'),        -- 21
('food'),         -- 22
('cat'),          -- 23
('dog'),          -- 24
('rabbit'),       -- 25
('star'),         -- 26
('heart'),        -- 27
('wave'),         -- 28
('think'),        -- 29
('magic'),        -- 30
('proud'),        -- 31
('shy'),          -- 32
('nervous'),      -- 33
('tired'),        -- 34
('celebrate'),    -- 35
('peace'),        -- 36
('punch'),        -- 37
('run'),          -- 38
('blush');        -- 39

-- 추가 Kaomoji 삽입 (ID 16-115)
INSERT INTO kaomoji (contents, password, status) VALUES
-- 행복/기쁨 계열
('(*^▽^*)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(≧◡≦)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(✿◠‿◠)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('＼(◎o◎)／', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ᵔᴥᵔ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 슬픔/우울 계열
('(´;ω;`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(T_T)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(;´༎ຶД༎ຶ`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´°̥̥̥̥̥̥̥̥ω°̥̥̥̥̥̥̥̥`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ´_ゝ`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 화남 계열
('(ノಠ益ಠ)ノ彡┻━┻', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(╬ Ò﹏Ó)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(҂`з´)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ಠ_ಠ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(`皿´＃)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 사랑 계열
('(♥ω♥*)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´∀`)♡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◕‿◕)♡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('♡(ŐωŐ人)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(●♡∀♡)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 귀여움 계열
('(=^･ω･^=)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(^・ω・^ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(=①ω①=)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('U・ᴥ・U', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◠ᴥ◠)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 놀람 계열
('Σ(°△°|||)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(⊙_⊙)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(°o°)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('w(°o°)w', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ʘᗩʘ'')', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 윙크 계열
('(^_~)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(~_^)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(^_−)☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ´∀`)σ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(^_<)〜☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 춤/신남 계열
('♪(´ε` )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('┌(★o☆)┘', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('♪♪ ヽ(ˇ∀ˇ )ゞ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヾ(⌐■_■)ノ♪', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ノ°∀°)ノ⌒・*:.。', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 졸림/피곤 계열
('(－ω－) zzZ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´〜`*) zzz', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ˘ω˘ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(-.-)...zzz', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヽ(´o｀；', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 혼란 계열
('(・・ ) ?', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´・ω・`)?', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(・_・ヾ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('╮(╯_╰)╭', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(⊙.⊙)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 동물 계열
('(=^-ω-^=)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ฅ^•ﻌ•^ฅ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ʕ·ᴥ·ʔ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(≧ᴗ≦)/', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 인사/손흔들기 계열
('(^-^)/', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´▽`)/♪', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヾ(・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ´ ▽ ` )ﾉ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(*・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 반짝/마법 계열
('☆*:.｡.o(≧▽≦)o.｡.:*☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ﾉ◕ヮ◕)ﾉ*:・゚✧', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('✧٩(ˊᗜˋ*)و✧', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ノ´ヮ´)ノ*:・゚✧', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('★~(◠‿◕✿)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 수줍음/부끄러움 계열
('(〃▽〃)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(//▽//)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(⁄ ⁄>⁄ ▽ ⁄<⁄ ⁄)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(*/ω＼*)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(/ω\)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 응원/힘내 계열
('(๑•̀ㅂ•́)و✧', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ᕦ(ò_óˇ)ᕤ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ง''̀-''́)ง', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(๑˃̵ᴗ˂̵)و', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('✧(σ๑˃̶̀ꇴ˂̶́)σ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 음식 계열
('( ˘▽˘)っ♨', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(っ˘ڡ˘ς)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ・ω・)o-{{[〃]}}', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('٩(^ᴗ^)۶ 🍰', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ･ω･)つ🍵', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 포옹/애정 계열
('(つ´∀`)つ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⊂(・▽・⊂)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⊂((・▽・))⊃', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(っ´▽｀)っ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヾ(＾∇＾)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 쿨/멋짐 계열
('( •̀ω•́ )σ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(☞ﾟ∀ﾟ)☞', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(▀̿Ĺ̯▀̿ ̿)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(⌐■_■)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 토끼 계열
('(・x・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('U( ´ㅅ`)U', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(˵ ͡° ͜ʖ ͡°˵)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⁽⁽◝( ˙ ꒳ ˙ )◜⁾⁾', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ˘ᴗ˘ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 생각/고민 계열
('(￣ヘ￣)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´-ω-`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ´_ゝ`)σ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ーー゛)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヽ(´ー｀)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 축하/파티 계열
('☆ヾ(*´・∀・)ノヾ(・∀・`*)ノ☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヽ(>∀<☆)★', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('★⌒ヽ(●´Д`●)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ノ^_^)ノ┻━┻ ☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('☆*ヾ(-∀・*)*+☆', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1);

-- 추가 Kaomoji-Tag 연결 (ID 16-115)
-- (*^▽^*) - happy, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (16, 1), (16, 15);
-- (≧◡≦) - happy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (17, 1), (17, 3);
-- (✿◠‿◠) - happy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (18, 1), (18, 3);
-- ＼(◎o◎)／ - surprised, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (19, 18), (19, 15);
-- (ᵔᴥᵔ) - cute, dog
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (20, 3), (20, 24);
-- (´;ω;`) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (21, 2), (21, 11);
-- (T_T) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (22, 2), (22, 11);
-- (;´༎ຶД༎ຶ`) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (23, 2), (23, 11);
-- (´°̥̥̥̥̥̥̥̥ω°̥̥̥̥̥̥̥̥`) - sad, cry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (24, 2), (24, 11);
-- ( ´_ゝ`) - calm
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (25, 14);
-- (ノಠ益ಠ)ノ彡┻━┻ - angry, flip
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (26, 4), (26, 13);
-- (╬ Ò﹏Ó) - angry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (27, 4);
-- (҂`з´) - angry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (28, 4);
-- (ಠ_ಠ) - angry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (29, 4);
-- (`皿´＃) - angry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (30, 4);
-- (♥ω♥*) - love, heart
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (31, 5), (31, 27);
-- (´∀`)♡ - love, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (32, 5), (32, 1);
-- (◕‿◕)♡ - love, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (33, 5), (33, 3);
-- ♡(ŐωŐ人) - love, heart
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (34, 5), (34, 27);
-- (●♡∀♡) - love, heart
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (35, 5), (35, 27);
-- (=^･ω･^=) - cat, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (36, 23), (36, 3);
-- (^・ω・^ ) - cat, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (37, 23), (37, 3);
-- (=①ω①=) - cat, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (38, 23), (38, 3);
-- U・ᴥ・U - dog, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (39, 24), (39, 3);
-- (◠ᴥ◠) - dog, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (40, 24), (40, 3);
-- Σ(°△°|||) - surprised
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (41, 18);
-- (⊙_⊙) - surprised
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (42, 18);
-- (°o°) - surprised
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (43, 18);
-- w(°o°)w - surprised, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (44, 18), (44, 15);
-- (ʘᗩʘ') - surprised, nervous
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (45, 18), (45, 33);
-- (^_~) - wink
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (46, 19);
-- (~_^) - wink
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (47, 19);
-- (^_−)☆ - wink, star
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (48, 19), (48, 26);
-- ( ´∀`)σ - wink, funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (49, 19), (49, 6);
-- (^_<)〜☆ - wink, star
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (50, 19), (50, 26);
-- ♪(´ε` ) - music, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (51, 21), (51, 1);
-- ┌(★o☆)┘ - dance, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (52, 20), (52, 15);
-- ♪♪ ヽ(ˇ∀ˇ )ゞ - dance, music
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (53, 20), (53, 21);
-- ヾ(⌐■_■)ノ♪ - dance, cool, music
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (54, 20), (54, 7), (54, 21);
-- (ノ°∀°)ノ⌒・*:.。 - excited, sparkle
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (55, 15), (55, 10);
-- (－ω－) zzZ - sleepy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (56, 16);
-- (´〜`*) zzz - sleepy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (57, 16);
-- ( ˘ω˘ ) - sleepy, calm
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (58, 16), (58, 14);
-- (-.-)...zzz - sleepy, tired
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (59, 16), (59, 34);
-- ヽ(´o｀； - tired
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (60, 34);
-- (・・ ) ? - confused
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (61, 17);
-- (´・ω・`)? - confused, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (62, 17), (62, 3);
-- (・_・ヾ - confused
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (63, 17);
-- ╮(╯_╰)╭ - shrug, confused
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (64, 8), (64, 17);
-- (⊙.⊙) - confused, surprised
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (65, 17), (65, 18);
-- (=^-ω-^=) - cat, sleepy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (66, 23), (66, 16);
-- ฅ^•ﻌ•^ฅ - cat, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (67, 23), (67, 3);
-- (・ω・)ノ - wave, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (68, 28), (68, 3);
-- ʕ·ᴥ·ʔ - bear, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (69, 9), (69, 3);
-- (≧ᴗ≦)/ - happy, wave
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (70, 1), (70, 28);
-- (^-^)/ - wave, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (71, 28), (71, 1);
-- (´▽`)/ ♪ - wave, happy, music
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (72, 28), (72, 1), (72, 21);
-- ヾ(・ω・)ノ - wave, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (73, 28), (73, 3);
-- ( ´ ▽ ` )ﾉ - wave, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (74, 28), (74, 1);
-- (*・ω・)ノ - wave, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (75, 28), (75, 3);
-- ☆*:.｡.o(≧▽≦)o.｡.:*☆ - sparkle, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (76, 10), (76, 15);
-- (ﾉ◕ヮ◕)ﾉ*:・゚✧ - sparkle, magic
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (77, 10), (77, 30);
-- ✧٩(ˊᗜˋ*)و✧ - sparkle, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (78, 10), (78, 15);
-- (ノ´ヮ´)ノ*:・゚✧ - sparkle, magic
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (79, 10), (79, 30);
-- ★~(◠‿◕✿) - star, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (80, 26), (80, 3);
-- (〃▽〃) - shy, blush
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (81, 32), (81, 39);
-- (//▽//) - shy, blush
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (82, 32), (82, 39);
-- (⁄ ⁄>⁄ ▽ ⁄<⁄ ⁄) - shy, blush
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (83, 32), (83, 39);
-- (*/ω＼*) - shy, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (84, 32), (84, 3);
-- (/ω\) - shy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (85, 32);
-- (๑•̀ㅂ•́)و✧ - proud, excited
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (86, 31), (86, 15);
-- ᕦ(ò_óˇ)ᕤ - proud, punch
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (87, 31), (87, 37);
-- (ง''̀-''́)ง - punch, angry
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (88, 37), (88, 4);
-- (๑˃̵ᴗ˂̵)و - excited, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (89, 15), (89, 1);
-- ✧(σ๑˃̶̀ꇴ˂̶́)σ - excited, sparkle
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (90, 15), (90, 10);
-- ( ˘▽˘)っ♨ - food, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (91, 22), (91, 1);
-- (っ˘ڡ˘ς) - food, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (92, 22), (92, 1);
-- ( ・ω・)o-{{[〃]}} - food
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (93, 22);
-- ٩(^ᴗ^)۶ 🍰 - food, celebrate
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (94, 22), (94, 35);
-- ( ･ω･)つ🍵 - food, calm
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (95, 22), (95, 14);
-- (つ´∀`)つ - hug, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (96, 12), (96, 1);
-- ⊂(・▽・⊂) - hug, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (97, 12), (97, 3);
-- ⊂((・▽・))⊃ - hug, happy
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (98, 12), (98, 1);
-- (っ´▽｀)っ - hug, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (99, 12), (99, 3);
-- ヾ(＾∇＾) - happy, wave
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (100, 1), (100, 28);
-- ( •̀ω•́ )σ - cool, proud
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (101, 7), (101, 31);
-- (☞ﾟ∀ﾟ)☞ - cool, funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (102, 7), (102, 6);
-- (̿▀̿ ̿Ĺ̯̿̿▀̿ ̿)̄ - cool
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (103, 7);
-- (▀̿Ĺ̯▀̿ ̿) - cool
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (104, 7);
-- (⌐■_■) - cool
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (105, 7);
-- (・x・) - rabbit, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (106, 25), (106, 3);
-- U( ´ㅅ`)U - rabbit, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (107, 25), (107, 3);
-- (˵ ͡° ͜ʖ ͡°˵) - funny
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (108, 6);
-- ⁽⁽◝( ˙ ꒳ ˙ )◜⁾⁾ - dance, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (109, 20), (109, 3);
-- ( ˘ᴗ˘ ) - calm, cute
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (110, 14), (110, 3);
-- (￣ヘ￣) - think
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (111, 29);
-- (´-ω-`) - think, calm
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (112, 29), (112, 14);
-- ( ´_ゝ`)σ - think
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (113, 29);
-- (ーー゛) - think, tired
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (114, 29), (114, 34);
-- ヽ(´ー｀)ノ - calm, peace
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (115, 14), (115, 36);

-- ========================================
-- 동식물 카오모지 50개 (ID 116-165)
-- ========================================

-- 동식물 관련 추가 태그 삽입
INSERT INTO tag (name) VALUES
('fish'),         -- 40
('bird'),         -- 41
('pig'),          -- 42
('monkey'),       -- 43
('mouse'),        -- 44
('sheep'),        -- 45
('cow'),          -- 46
('chicken'),      -- 47
('frog'),         -- 48
('snake'),        -- 49
('turtle'),       -- 50
('whale'),        -- 51
('dolphin'),      -- 52
('butterfly'),    -- 53
('bee'),          -- 54
('spider'),       -- 55
('penguin'),      -- 56
('panda'),        -- 57
('elephant'),     -- 58
('lion'),         -- 59
('tiger'),        -- 60
('fox'),          -- 61
('owl'),          -- 62
('duck'),         -- 63
('crab'),         -- 64
('octopus'),      -- 65
('plant'),        -- 66
('flower'),       -- 67
('tree'),         -- 68
('leaf');         -- 69

-- 동식물 Kaomoji 삽입 (ID 116-165)
INSERT INTO kaomoji (contents, password, status) VALUES
-- 물고기 계열
('>°))))彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('<・)))><<', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('>゜))))彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ζ°)))彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('<゜)))彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 새 계열
('(・θ・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(°<°)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('Σ( °△°)︴', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(•ө•)♡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('◎▼◎', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 돼지 계열
('( ´(00)`)ﾉ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(￣(oo)￣)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ˘ ³˘)♥', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ヾ(＠＾(oo)＾＠)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(￣(エ)￣)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 원숭이 계열
('@(・●・)@', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🙈', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('@( o・ェ・)@', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ε=ε=┏(　・_・)┛', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◉Θ◉)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 쥐 계열
('(=´∇`=)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('<:3 )~~~~', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ↀДↀ)⁼³₌₃', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(=^・^=)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('~(=^‥^)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 양/소/닭 계열
('(´・ω・)つ旦', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(o^∀^)o', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(`・ω・´)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◕ᴗ◕✿)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('▼・ᴥ・▼', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 개구리/뱀/거북이 계열
('( ﾟoﾟ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('~>°)___/', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ˘ ε ˘ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('_(:3」∠)_', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(˘▾˘~)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 해양생물 계열
('くコ:彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('C:。ミ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(゜))<<', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('≧( ° ° )≦', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('ミ(・・)ミ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 곤충 계열
('(ง •̀_•́)ง', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('彡ﾟ◉ω◉ )つー', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('/╲/( •̀ ω •́ )/\╱\\', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('@＼("▔□▔)/@', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(°ロ°) !', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 기타 동물
('(・⊝・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(◉(エ)◉)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(￣ー￣)ゞ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ≧ᗜ≦)/', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(ↀДↀ)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1);

-- 동식물 Kaomoji-Tag 연결 (ID 116-165)
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (116, 40), (116, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (117, 40);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (118, 40);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (119, 40), (119, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (120, 40);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (121, 41), (121, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (122, 41);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (123, 41), (123, 18);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (124, 41), (124, 5);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (125, 62);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (126, 42), (126, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (127, 42);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (128, 42), (128, 5);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (129, 42), (129, 1);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (130, 9);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (131, 43), (131, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (132, 43);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (133, 43), (133, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (134, 38);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (135, 62);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (136, 44), (136, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (137, 44);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (138, 23);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (139, 23), (139, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (140, 23), (140, 28);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (141, 45);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (142, 46);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (143, 47);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (144, 67), (144, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (145, 24), (145, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (146, 48);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (147, 49);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (148, 50);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (149, 50), (149, 16);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (150, 50);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (151, 65);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (152, 40);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (153, 51);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (154, 64);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (155, 64), (155, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (156, 53);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (157, 54);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (158, 55);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (159, 53);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (160, 18);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (161, 56), (161, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (162, 57), (162, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (163, 7);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (164, 1), (164, 28);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (165, 23);

-- ========================================
-- 사물 카오모지 50개 (ID 166-215)
-- ========================================

-- 사물 관련 추가 태그 삽입
INSERT INTO tag (name) VALUES
('sun'),          -- 70
('moon'),         -- 71
('cloud'),        -- 72
('rain'),         -- 73
('snow'),         -- 74
('fire'),         -- 75
('water'),        -- 76
('gift'),         -- 77
('camera'),       -- 78
('glasses'),      -- 79
('hat'),          -- 80
('key'),          -- 81
('robot'),        -- 82
('sword'),        -- 83
('shield'),       -- 84
('game'),         -- 85
('tv'),           -- 86
('mail'),         -- 87
('money'),        -- 88
('box'),          -- 89
('clock'),        -- 90
('umbrella'),     -- 91
('phone'),        -- 92
('computer'),     -- 93
('book'),         -- 94
('pen'),          -- 95
('house'),        -- 96
('car'),          -- 97
('train'),        -- 98
('plane');        -- 99

-- 사물 Kaomoji 삽입 (ID 166-215)
INSERT INTO kaomoji (contents, password, status) VALUES
-- 날씨/자연 계열
('☀️ヽ(´ー`)ノ☀️', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🌙(￣o￣) . z Z', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('( ´ ▽ ` )☁️', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´；ω；`)☔', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('❄️(´• ω •`)❄️', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🔥(｀ε´)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('💧(´ω`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('☆彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('★彡', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⁂(◕‿◕)⁂', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 선물/파티 계열
('🎁(≧▽≦)🎁', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('(´ε｀ )♡🎀', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎂(◠‿◠)🎂', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎉ヽ(^o^)丿🎉', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎊(≧◡≦)🎊', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 게임/엔터테인먼트 계열
('🎮(｀・ω・´)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('📺( ˘ω˘ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎬(•̀ᴗ•́)و', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎵♪(´ε｀ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🎸ヾ(⌐■_■)ノ♪', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 통신/전자기기 계열
('📱(・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('💻(•̀ᴗ•́)و', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('📷(^-^)v', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('📧(´・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⌨️(　˙-˙　)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 학용품/도구 계열
('📚(´・ω・)σ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('✏️(´ε｀ )', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('📖(｡◕‿◕｡)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('✂️(´・ω・`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🔧(•̀ᴗ•́)و', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 교통수단 계열
('🚗(´・∀・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🚃(´ω`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('✈️(◉‿◉)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🚀(≧▽≦)/', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🚲(´∀`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 건물/장소 계열
('🏠(´・ω・`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🏢(・_・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🏫(◕‿◕✿)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🏥(´;ω;`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('⛪(´-ω-`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 무기/방어구 계열
('⚔️(｀ε´)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🛡️(・`ω´・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🏹(◎_◎;)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🔫(▀̿Ĺ̯▀̿ ̿)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('💣(º_º)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
-- 돈/재화 계열
('💰(☆▽☆)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('💎(◕‿◕)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('💵(´∀`)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('🔑(・ω・)', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1),
('📦(´・ω・)ノ', '1be0222750aaf3889ab95c8d0624eaf59bb0ce4f7dd9e868b06783c027626219', 1);

-- 사물 Kaomoji-Tag 연결 (ID 166-215)
-- 날씨/자연
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (166, 70), (166, 1);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (167, 71), (167, 16);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (168, 72), (168, 1);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (169, 73), (169, 2);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (170, 74), (170, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (171, 75), (171, 4);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (172, 76);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (173, 26), (173, 10);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (174, 26), (174, 10);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (175, 26), (175, 3);
-- 선물/파티
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (176, 77), (176, 15);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (177, 77), (177, 5);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (178, 35), (178, 1);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (179, 35), (179, 15);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (180, 35), (180, 1);
-- 게임/엔터테인먼트
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (181, 85);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (182, 86), (182, 16);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (183, 86);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (184, 21);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (185, 21), (185, 7);
-- 통신/전자기기
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (186, 92);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (187, 93);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (188, 78);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (189, 87);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (190, 93);
-- 학용품/도구
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (191, 94);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (192, 95);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (193, 94), (193, 3);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (194, 95);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (195, 29);
-- 교통수단
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (196, 97);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (197, 98);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (198, 99);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (199, 99), (199, 15);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (200, 97);
-- 건물/장소
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (201, 96);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (202, 96);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (203, 94);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (204, 2);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (205, 14);
-- 무기/방어구
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (206, 83);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (207, 84);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (208, 83);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (209, 7);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (210, 18);
-- 돈/재화
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (211, 88), (211, 15);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (212, 88), (212, 10);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (213, 88);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (214, 81);
INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (215, 89);

