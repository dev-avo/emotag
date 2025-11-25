/**
 * /api/kaomoji/search?tag=태그명
 * GET: 태그로 Kaomoji 검색
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
    const { env, request } = context;
    const url = new URL(request.url);
    const tagQuery = url.searchParams.get('tag');

    if(!tagQuery) {
        return new Response(JSON.stringify({
            success: false,
            error: 'tag 파라미터 필수'
        }), {
            status: 400,
            headers: { 'Content-Type': 'application/json', ...corsHeaders }
        });
    }

    try {
        // 태그명으로 검색 (부분 일치)
        const result = await env.EMOTAG_DB.prepare(`
            SELECT 
                k.id,
                k.contents,
                k.created_at,
                k.updated_at,
                GROUP_CONCAT(t2.name) as tags
            FROM kaomoji k
            INNER JOIN kaomoji_tag kt ON k.id = kt.kaomoji_id
            INNER JOIN tag t ON kt.tag_id = t.id
            LEFT JOIN kaomoji_tag kt2 ON k.id = kt2.kaomoji_id
            LEFT JOIN tag t2 ON kt2.tag_id = t2.id
            WHERE k.status = 1 AND t.name LIKE ?
            GROUP BY k.id
            ORDER BY k.created_at DESC
        `).bind(`%${tagQuery.toLowerCase()}%`).all();

        const kaomojis = result.results.map(row => ({
            ...row,
            tags: row.tags ? row.tags.split(',') : []
        }));

        return new Response(JSON.stringify({
            success: true,
            data: kaomojis
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

