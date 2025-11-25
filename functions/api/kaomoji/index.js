/**
 * /api/kaomoji
 * GET: 전체 Kaomoji 목록 조회 (status=1)
 * POST: 새 Kaomoji 등록
 */

// 비밀번호 해시 함수 (SHA-256)
async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

// CORS 헤더
const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
};

// OPTIONS 요청 처리 (CORS preflight)
export async function onRequestOptions() {
    return new Response(null, { headers: corsHeaders });
}

// GET: 전체 목록 조회
export async function onRequestGet(context) {
    const { env } = context;

    try {
        // kaomoji와 tag를 JOIN하여 조회
        const result = await env.EMOTAG_DB.prepare(`
            SELECT 
                k.id,
                k.contents,
                k.created_at,
                k.updated_at,
                GROUP_CONCAT(t.name) as tags
            FROM kaomoji k
            LEFT JOIN kaomoji_tag kt ON k.id = kt.kaomoji_id
            LEFT JOIN tag t ON kt.tag_id = t.id
            WHERE k.status = 1
            GROUP BY k.id
            ORDER BY k.created_at DESC
        `).all();

        // tags 문자열을 배열로 변환
        const kaomojis = result.results.map(row => ({
            ...row,
            tags: row.tags ? row.tags.split(',') : []
        }));

        return new Response(JSON.stringify({
            success: true,
            data: kaomojis
        }), {
            headers: {
                'Content-Type': 'application/json',
                ...corsHeaders
            }
        });
    } catch (error) {
        return new Response(JSON.stringify({
            success: false,
            error: error.message
        }), {
            status: 500,
            headers: {
                'Content-Type': 'application/json',
                ...corsHeaders
            }
        });
    }
}

// POST: 새 Kaomoji 등록
export async function onRequestPost(context) {
    const { env, request } = context;

    try {
        const body = await request.json();
        const { contents, password, tags } = body;

        // 유효성 검사
        if(!contents || !password || !tags || !Array.isArray(tags) || tags.length === 0) {
            return new Response(JSON.stringify({
                success: false,
                error: 'contents, password, tags(배열, 1개 이상) 필수'
            }), {
                status: 400,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 중복 검사
        const existing = await env.EMOTAG_DB.prepare(
            'SELECT id FROM kaomoji WHERE contents = ?'
        ).bind(contents).first();

        if(existing) {
            return new Response(JSON.stringify({
                success: false,
                error: '이미 등록된 Kaomoji입니다'
            }), {
                status: 409,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 비밀번호 해시
        const hashedPassword = await hashPassword(password);

        // Kaomoji 삽입
        const insertResult = await env.EMOTAG_DB.prepare(
            'INSERT INTO kaomoji (contents, password) VALUES (?, ?)'
        ).bind(contents, hashedPassword).run();

        const kaomojiId = insertResult.meta.last_row_id;

        // 태그 처리: 없으면 생성, 있으면 ID 가져오기
        for(const tagName of tags) {
            const trimmedTag = tagName.trim().toLowerCase();
            if(!trimmedTag) continue;

            // 태그 삽입 또는 무시 (UNIQUE 제약)
            await env.EMOTAG_DB.prepare(
                'INSERT OR IGNORE INTO tag (name) VALUES (?)'
            ).bind(trimmedTag).run();

            // 태그 ID 조회
            const tagRow = await env.EMOTAG_DB.prepare(
                'SELECT id FROM tag WHERE name = ?'
            ).bind(trimmedTag).first();

            // kaomoji_tag 연결
            await env.EMOTAG_DB.prepare(
                'INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (?, ?)'
            ).bind(kaomojiId, tagRow.id).run();
        }

        return new Response(JSON.stringify({
            success: true,
            data: { id: kaomojiId, contents, tags }
        }), {
            status: 201,
            headers: { 'Content-Type': 'application/json', ...corsHeaders }
        });

    } catch (error) {
        return new Response(JSON.stringify({
            success: false,
            error: error.message
        }), {
            status: 500,
            headers: { 'Content-Type': 'application/json', ...corsHeaders }
        });
    }
}

