/**
 * emotag - 유틸리티 함수
 */

// ===========================================
// API 호출 유틸리티
// ===========================================

const API_BASE = '/api';

/**
 * API 요청 함수
 * @param {string} endpoint - API 엔드포인트
 * @param {object} options - fetch 옵션
 * @returns {Promise<object>} - API 응답
 */
async function api(endpoint, options = {}) {
    const url = `${API_BASE}${endpoint}`;
    const config = {
        headers: {
            'Content-Type': 'application/json',
        },
        ...options,
    };

    if(config.body && typeof config.body === 'object') {
        config.body = JSON.stringify(config.body);
    }

    try {
        const response = await fetch(url, config);
        const data = await response.json();

        if(!response.ok) {
            throw new Error(data.error || '요청 실패');
        }

        return data;
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

/**
 * GET 요청
 */
async function apiGet(endpoint) {
    return api(endpoint, { method: 'GET' });
}

/**
 * POST 요청
 */
async function apiPost(endpoint, body) {
    return api(endpoint, { method: 'POST', body });
}

/**
 * PUT 요청
 */
async function apiPut(endpoint, body) {
    return api(endpoint, { method: 'PUT', body });
}

/**
 * DELETE 요청
 */
async function apiDelete(endpoint, body) {
    return api(endpoint, { method: 'DELETE', body });
}

// ===========================================
// Kaomoji API 래퍼
// ===========================================

const KaomojiAPI = {
    // 전체 목록 조회
    getAll: () => apiGet('/kaomoji'),

    // 태그로 검색
    search: (tag) => apiGet(`/kaomoji/search?tag=${encodeURIComponent(tag)}`),

    // 랜덤 1개
    getRandom: () => apiGet('/kaomoji/random'),

    // 단일 조회
    getById: (id) => apiGet(`/kaomoji/${id}`),

    // 등록
    create: (contents, password, tags) => apiPost('/kaomoji', { contents, password, tags }),

    // 수정
    update: (id, contents, password, tags) => apiPut(`/kaomoji/${id}`, { contents, password, tags }),

    // 삭제
    delete: (id, password) => apiDelete(`/kaomoji/${id}`, { password }),

    // 비밀번호 검증
    verify: (id, password) => apiPost(`/kaomoji/${id}/verify`, { password }),
};

// 태그 API
const TagAPI = {
    getAll: () => apiGet('/tag'),
};

// ===========================================
// 클립보드 복사
// ===========================================

/**
 * 텍스트를 클립보드에 복사
 * @param {string} text - 복사할 텍스트
 * @returns {Promise<boolean>} - 성공 여부
 */
async function copyToClipboard(text) {
    try {
        // 최신 Clipboard API 사용
        if(navigator.clipboard && navigator.clipboard.writeText) {
            await navigator.clipboard.writeText(text);
            return true;
        }

        // 폴백: execCommand 사용
        const textarea = document.createElement('textarea');
        textarea.value = text;
        textarea.style.position = 'fixed';
        textarea.style.left = '-9999px';
        document.body.appendChild(textarea);
        textarea.select();
        document.execCommand('copy');
        document.body.removeChild(textarea);
        return true;
    } catch (error) {
        console.error('복사 실패:', error);
        return false;
    }
}

// ===========================================
// 토스트 메시지
// ===========================================

/**
 * 토스트 메시지 표시
 * @param {string} message - 메시지 내용
 * @param {string} type - 'success' | 'error' | 'default'
 * @param {number} duration - 표시 시간 (ms)
 */
function showToast(message, type = 'default', duration = 3000) {
    // 토스트 컨테이너 확인/생성
    let container = document.querySelector('.toast-container');
    if(!container) {
        container = document.createElement('div');
        container.className = 'toast-container';
        document.body.appendChild(container);
    }

    // 토스트 요소 생성
    const toast = document.createElement('div');
    toast.className = `toast toast--${type}`;
    toast.textContent = message;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', 'polite');

    container.appendChild(toast);

    // 일정 시간 후 제거
    setTimeout(() => {
        toast.remove();
        // 컨테이너가 비어있으면 제거
        if(container.children.length === 0) {
            container.remove();
        }
    }, duration);
}

// ===========================================
// 모달
// ===========================================

/**
 * 모달 열기
 * @param {string} modalId - 모달 요소 ID
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if(modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';

        // 포커스 트랩
        const focusableElements = modal.querySelectorAll(
            'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
        );
        if(focusableElements.length > 0) {
            focusableElements[0].focus();
        }
    }
}

/**
 * 모달 닫기
 * @param {string} modalId - 모달 요소 ID
 */
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if(modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}

/**
 * 비밀번호 확인 모달
 * @param {number} kaomojiId - Kaomoji ID
 * @param {function} onSuccess - 인증 성공 시 콜백
 */
function showPasswordModal(kaomojiId, onSuccess) {
    // 기존 모달 제거
    const existingModal = document.getElementById('password-modal');
    if(existingModal) {
        existingModal.remove();
    }

    // 모달 HTML 생성
    const modalHtml = `
        <div class="modal-overlay" id="password-modal">
            <div class="modal" role="dialog" aria-labelledby="modal-title" aria-modal="true">
                <h2 class="modal__title" id="modal-title">비밀번호 확인</h2>
                <div class="form-group">
                    <label class="form-group__label" for="modal-password">비밀번호</label>
                    <input type="password" id="modal-password" class="form-group__input" placeholder="비밀번호를 입력하세요" autocomplete="off">
                    <p class="form-group__error" id="modal-error" style="display: none;"></p>
                </div>
                <div class="modal__actions">
                    <button type="button" class="btn btn--outline" id="modal-cancel">취소</button>
                    <button type="button" class="btn btn--primary" id="modal-confirm">확인</button>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHtml);
    openModal('password-modal');

    const modal = document.getElementById('password-modal');
    const passwordInput = document.getElementById('modal-password');
    const errorEl = document.getElementById('modal-error');
    const cancelBtn = document.getElementById('modal-cancel');
    const confirmBtn = document.getElementById('modal-confirm');

    // 취소 버튼
    cancelBtn.addEventListener('click', function() {
        closeModal('password-modal');
        modal.remove();
    });

    // 오버레이 클릭 시 닫기
    modal.addEventListener('click', function(e) {
        if(e.target === modal) {
            closeModal('password-modal');
            modal.remove();
        }
    });

    // 확인 버튼
    async function handleConfirm() {
        const password = passwordInput.value.trim();

        if(!password) {
            errorEl.textContent = '비밀번호를 입력하세요';
            errorEl.style.display = 'block';
            return;
        }

        confirmBtn.disabled = true;
        confirmBtn.textContent = '확인 중...';

        try {
            await KaomojiAPI.verify(kaomojiId, password);
            closeModal('password-modal');
            modal.remove();
            onSuccess(password);
        } catch (error) {
            errorEl.textContent = error.message || '비밀번호가 일치하지 않습니다';
            errorEl.style.display = 'block';
            confirmBtn.disabled = false;
            confirmBtn.textContent = '확인';
        }
    }

    confirmBtn.addEventListener('click', handleConfirm);

    // Enter 키로 확인
    passwordInput.addEventListener('keydown', function(e) {
        if(e.key === 'Enter') {
            handleConfirm();
        }
    });

    // ESC 키로 닫기
    document.addEventListener('keydown', function escHandler(e) {
        if(e.key === 'Escape') {
            closeModal('password-modal');
            modal.remove();
            document.removeEventListener('keydown', escHandler);
        }
    });
}

// ===========================================
// DOM 유틸리티
// ===========================================

/**
 * 요소 생성 헬퍼
 * @param {string} tag - 태그명
 * @param {object} attrs - 속성
 * @param {string|Node|Array} children - 자식 요소
 */
function createElement(tag, attrs = {}, children = null) {
    const el = document.createElement(tag);

    for(const [key, value] of Object.entries(attrs)) {
        if(key === 'className') {
            el.className = value;
        } else if(key === 'dataset') {
            for(const [dataKey, dataValue] of Object.entries(value)) {
                el.dataset[dataKey] = dataValue;
            }
        } else if(key.startsWith('on')) {
            el.addEventListener(key.slice(2).toLowerCase(), value);
        } else {
            el.setAttribute(key, value);
        }
    }

    if(children) {
        if(Array.isArray(children)) {
            children.forEach(child => {
                if(typeof child === 'string') {
                    el.appendChild(document.createTextNode(child));
                } else if(child) {
                    el.appendChild(child);
                }
            });
        } else if(typeof children === 'string') {
            el.textContent = children;
        } else {
            el.appendChild(children);
        }
    }

    return el;
}

/**
 * URL 파라미터 가져오기
 * @param {string} name - 파라미터 이름
 */
function getUrlParam(name) {
    const params = new URLSearchParams(window.location.search);
    return params.get(name);
}

/**
 * 디바운스 함수
 * @param {function} func - 실행할 함수
 * @param {number} wait - 대기 시간 (ms)
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = function() {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

