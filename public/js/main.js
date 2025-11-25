/**
 * emotag - 메인 페이지 스크립트
 */

// DOM 요소
const searchInput = document.getElementById('search-input');
const searchBtn = document.getElementById('search-btn');
const randomBtn = document.getElementById('random-btn');
const loadingEl = document.getElementById('loading');
const kaomojiListEl = document.getElementById('kaomoji-list');
const emptyStateEl = document.getElementById('empty-state');

// 상태
let currentKaomojis = [];

// ===========================================
// 초기화
// ===========================================

document.addEventListener('DOMContentLoaded', function() {
    // 전체 목록 로드
    loadKaomojis();

    // 이벤트 리스너 등록
    searchBtn.addEventListener('click', handleSearch);
    searchInput.addEventListener('keydown', function(e) {
        if(e.key === 'Enter') {
            handleSearch();
        }
    });

    // 검색어 입력 시 실시간 검색 (디바운스 적용)
    searchInput.addEventListener('input', debounce(function() {
        if(searchInput.value.trim()) {
            handleSearch();
        } else {
            loadKaomojis();
        }
    }, 300));

    randomBtn.addEventListener('click', handleRandom);
});

// ===========================================
// 데이터 로드
// ===========================================

/**
 * 전체 Kaomoji 목록 로드
 */
async function loadKaomojis() {
    showLoading();

    try {
        const response = await KaomojiAPI.getAll();
        currentKaomojis = response.data;
        renderKaomojis(currentKaomojis);
    } catch (error) {
        showToast(error.message || '목록을 불러오는데 실패했습니다', 'error');
        showEmpty();
    }
}

/**
 * 태그로 검색
 */
async function handleSearch() {
    const query = searchInput.value.trim();

    if(!query) {
        loadKaomojis();
        return;
    }

    showLoading();

    try {
        const response = await KaomojiAPI.search(query);
        currentKaomojis = response.data;
        renderKaomojis(currentKaomojis);
    } catch (error) {
        showToast(error.message || '검색에 실패했습니다', 'error');
        showEmpty();
    }
}

/**
 * 랜덤 Kaomoji 표시
 */
async function handleRandom() {
    try {
        const response = await KaomojiAPI.getRandom();
        const kaomoji = response.data;

        // 랜덤 결과만 표시
        currentKaomojis = [kaomoji];
        renderKaomojis(currentKaomojis);

        // 복사
        const copied = await copyToClipboard(kaomoji.contents);
        if(copied) {
            showToast(`${kaomoji.contents} 복사되었습니다!`, 'success');
        }
    } catch (error) {
        showToast(error.message || '랜덤 카오모지를 가져오는데 실패했습니다', 'error');
    }
}

// ===========================================
// 렌더링
// ===========================================

/**
 * Kaomoji 목록 렌더링
 * @param {Array} kaomojis - Kaomoji 배열
 */
function renderKaomojis(kaomojis) {
    hideLoading();

    if(!kaomojis || kaomojis.length === 0) {
        showEmpty();
        return;
    }

    showList();
    kaomojiListEl.innerHTML = kaomojis.map(kaomoji => createKaomojiCard(kaomoji)).join('');

    // 이벤트 위임으로 클릭 이벤트 처리
    kaomojiListEl.addEventListener('click', handleCardClick);
}

/**
 * Kaomoji 카드 HTML 생성
 * @param {object} kaomoji - Kaomoji 데이터
 */
function createKaomojiCard(kaomoji) {
    const tagsHtml = kaomoji.tags.map(tag => 
        `<span class="tag" data-action="search-tag" data-tag="${escapeHtml(tag)}">#${escapeHtml(tag)}</span>`
    ).join('');

    return `
        <article class="kaomoji-card" data-id="${kaomoji.id}">
            <div class="kaomoji-card__content" data-action="copy" data-contents="${escapeHtml(kaomoji.contents)}" title="클릭하여 복사">
                ${escapeHtml(kaomoji.contents)}
            </div>
            <div class="kaomoji-card__tags">
                ${tagsHtml}
            </div>
            <div class="kaomoji-card__actions">
                <button type="button" class="btn btn--small btn--ghost" data-action="copy" data-contents="${escapeHtml(kaomoji.contents)}" title="복사">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
                        <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
                    </svg>
                </button>
                <button type="button" class="btn btn--small btn--ghost" data-action="edit" data-id="${kaomoji.id}" title="수정">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                    </svg>
                </button>
            </div>
        </article>
    `;
}

/**
 * 카드 클릭 이벤트 핸들러 (이벤트 위임)
 */
async function handleCardClick(e) {
    const target = e.target.closest('[data-action]');
    if(!target) return;

    const action = target.dataset.action;

    switch(action) {
        case 'copy':
            const contents = target.dataset.contents;
            const copied = await copyToClipboard(contents);
            if(copied) {
                showToast(`${contents} 복사되었습니다!`, 'success');
            } else {
                showToast('복사에 실패했습니다', 'error');
            }
            break;

        case 'search-tag':
            const tag = target.dataset.tag;
            searchInput.value = tag;
            handleSearch();
            break;

        case 'edit':
            const id = target.dataset.id;
            showPasswordModal(parseInt(id), function(password) {
                // 비밀번호 검증 성공 시 수정 페이지로 이동
                // 비밀번호를 sessionStorage에 임시 저장 (보안상 주의)
                sessionStorage.setItem('edit_password', password);
                window.location.href = `/edit.html?id=${id}`;
            });
            break;
    }
}

// ===========================================
// UI 상태 관리
// ===========================================

function showLoading() {
    loadingEl.style.display = 'flex';
    kaomojiListEl.style.display = 'none';
    emptyStateEl.style.display = 'none';
}

function hideLoading() {
    loadingEl.style.display = 'none';
}

function showList() {
    kaomojiListEl.style.display = 'flex';
    emptyStateEl.style.display = 'none';
}

function showEmpty() {
    kaomojiListEl.style.display = 'none';
    emptyStateEl.style.display = 'block';
}

// ===========================================
// 유틸리티
// ===========================================

/**
 * HTML 이스케이프
 */
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

