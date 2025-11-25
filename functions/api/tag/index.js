/**
 * /api/tag
 * GET: 전체 태그 목록 조회
 */

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
};

export async function onRequestOptions() {
    return new Response(null, { headers: corsHeaders });
}

export async function onRequestGet(context) {
    const { env } = context;

    try {
        // 사용 중인 태그만 조회 (활성 kaomoji에 연결된 태그)
        const result = await env.EMOTAG_DB.prepare(`
            SELECT DISTINCT t.id, t.name
            FROM tag t
            INNER JOIN kaomoji_tag kt ON t.id = kt.tag_id
            INNER JOIN kaomoji k ON kt.kaomoji_id = k.id
            WHERE k.status = 1
            ORDER BY t.name ASC
        `).all();

        return new Response(JSON.stringify({
            success: true,
            data: result.results
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

