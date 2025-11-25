/**
 * /api/kaomoji/:id
 * GET: 특정 Kaomoji 조회
 * PUT: Kaomoji 수정 (비밀번호 필요)
 * DELETE: Kaomoji 삭제 - Soft delete (비밀번호 필요)
 */

async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
}

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
};

export async function onRequestOptions() {
    return new Response(null, { headers: corsHeaders });
}

// GET: 특정 Kaomoji 조회
export async function onRequestGet(context) {
    const { env, params } = context;
    const id = params.id;

    try {
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
            WHERE k.id = ? AND k.status = 1
            GROUP BY k.id
        `).bind(id).first();

        if(!result) {
            return new Response(JSON.stringify({
                success: false,
                error: 'Kaomoji를 찾을 수 없습니다'
            }), {
                status: 404,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        const kaomoji = {
            ...result,
            tags: result.tags ? result.tags.split(',') : []
        };

        return new Response(JSON.stringify({
            success: true,
            data: kaomoji
        }), {
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

// PUT: Kaomoji 수정
export async function onRequestPut(context) {
    const { env, params, request } = context;
    const id = params.id;

    try {
        const body = await request.json();
        const { contents, password, tags } = body;

        // 유효성 검사
        if(!password) {
            return new Response(JSON.stringify({
                success: false,
                error: '비밀번호 필수'
            }), {
                status: 400,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 기존 데이터 조회
        const existing = await env.EMOTAG_DB.prepare(
            'SELECT * FROM kaomoji WHERE id = ? AND status = 1'
        ).bind(id).first();

        if(!existing) {
            return new Response(JSON.stringify({
                success: false,
                error: 'Kaomoji를 찾을 수 없습니다'
            }), {
                status: 404,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 비밀번호 검증
        const hashedPassword = await hashPassword(password);
        if(hashedPassword !== existing.password) {
            return new Response(JSON.stringify({
                success: false,
                error: '비밀번호가 일치하지 않습니다'
            }), {
                status: 401,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // contents 수정
        if(contents && contents !== existing.contents) {
            // 중복 검사
            const duplicate = await env.EMOTAG_DB.prepare(
                'SELECT id FROM kaomoji WHERE contents = ? AND id != ?'
            ).bind(contents, id).first();

            if(duplicate) {
                return new Response(JSON.stringify({
                    success: false,
                    error: '이미 등록된 Kaomoji입니다'
                }), {
                    status: 409,
                    headers: { 'Content-Type': 'application/json', ...corsHeaders }
                });
            }

            await env.EMOTAG_DB.prepare(
                'UPDATE kaomoji SET contents = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?'
            ).bind(contents, id).run();
        }

        // tags 수정
        if(tags && Array.isArray(tags) && tags.length > 0) {
            // 기존 태그 연결 삭제
            await env.EMOTAG_DB.prepare(
                'DELETE FROM kaomoji_tag WHERE kaomoji_id = ?'
            ).bind(id).run();

            // 새 태그 연결
            for(const tagName of tags) {
                const trimmedTag = tagName.trim().toLowerCase();
                if(!trimmedTag) continue;

                await env.EMOTAG_DB.prepare(
                    'INSERT OR IGNORE INTO tag (name) VALUES (?)'
                ).bind(trimmedTag).run();

                const tagRow = await env.EMOTAG_DB.prepare(
                    'SELECT id FROM tag WHERE name = ?'
                ).bind(trimmedTag).first();

                await env.EMOTAG_DB.prepare(
                    'INSERT INTO kaomoji_tag (kaomoji_id, tag_id) VALUES (?, ?)'
                ).bind(id, tagRow.id).run();
            }
        }

        return new Response(JSON.stringify({
            success: true,
            message: '수정되었습니다'
        }), {
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

// DELETE: Soft delete (status = -1)
export async function onRequestDelete(context) {
    const { env, params, request } = context;
    const id = params.id;

    try {
        const body = await request.json();
        const { password } = body;

        if(!password) {
            return new Response(JSON.stringify({
                success: false,
                error: '비밀번호 필수'
            }), {
                status: 400,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 기존 데이터 조회
        const existing = await env.EMOTAG_DB.prepare(
            'SELECT * FROM kaomoji WHERE id = ? AND status = 1'
        ).bind(id).first();

        if(!existing) {
            return new Response(JSON.stringify({
                success: false,
                error: 'Kaomoji를 찾을 수 없습니다'
            }), {
                status: 404,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // 비밀번호 검증
        const hashedPassword = await hashPassword(password);
        if(hashedPassword !== existing.password) {
            return new Response(JSON.stringify({
                success: false,
                error: '비밀번호가 일치하지 않습니다'
            }), {
                status: 401,
                headers: { 'Content-Type': 'application/json', ...corsHeaders }
            });
        }

        // Soft delete
        await env.EMOTAG_DB.prepare(
            'UPDATE kaomoji SET status = -1, updated_at = CURRENT_TIMESTAMP WHERE id = ?'
        ).bind(id).run();

        return new Response(JSON.stringify({
            success: true,
            message: '삭제되었습니다'
        }), {
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

