/**
 * /api/kaomoji/:id/verify
 * POST: 비밀번호 검증 (수정 페이지 접근 전 확인용)
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
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
};

export async function onRequestOptions() {
    return new Response(null, { headers: corsHeaders });
}

export async function onRequestPost(context) {
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
            'SELECT password FROM kaomoji WHERE id = ? AND status = 1'
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

        return new Response(JSON.stringify({
            success: true,
            message: '인증 성공'
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

