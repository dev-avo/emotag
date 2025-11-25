/**
 * /api/kaomoji/random
 * GET: 랜덤 Kaomoji 1개 조회
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
        // 랜덤 1개 조회 (SQLite RANDOM() 사용)
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
            ORDER BY RANDOM()
            LIMIT 1
        `).first();

        if(!result) {
            return new Response(JSON.stringify({
                success: false,
                error: '등록된 Kaomoji가 없습니다'
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

