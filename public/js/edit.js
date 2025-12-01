/**
 * emotag - 수정 페이지 스크립트
 */

// DOM 요소
const loadingEl = document.getElementById('loading');
const errorStateEl = document.getElementById('error-state');
const editContentEl = document.getElementById('edit-content');
const editForm = document.getElementById('edit-form');
const kaomojiInput = document.getElementById('kaomoji-input');
const tagInputContainer = document.getElementById('tag-input-container');
const tagInput = document.getElementById('tag-input');
const tagList = document.getElementById('tag-list');
const submitBtn = document.getElementById('submit-btn');
const deleteBtn = document.getElementById('delete-btn');

// 에러 요소
const kaomojiError = document.getElementById('kaomoji-error');
const tagError = document.getElementById('tag-error');

// 모달 요소
const deleteModal = document.getElementById('delete-modal');
const deleteCancelBtn = document.getElementById('delete-cancel');
const deleteConfirmBtn = document.getElementById('delete-confirm');

// 상태
let kaomojiId = null;
let tags = [];
let password = null;
let originalData = null;

// ===========================================
// 초기화
// ===========================================

document.addEventListener('DOMContentLoaded', function() {
    // URL에서 ID 추출
    kaomojiId = getUrlParam('id');

    if(!kaomojiId) {
        showError();
        return;
    }

    // sessionStorage에서 비밀번호 가져오기
    password = sessionStorage.getItem('edit_password');
    
    if(!password) {
        // 비밀번호가 없으면 홈으로 리다이렉트
        showToast('비밀번호 인증이 필요합니다.', 'error');
        setTimeout(function() {
            window.location.href = '/';
        }, 1000);
        return;
    }

    // 데이터 로드
    loadKaomojiData();

    // 이벤트 리스너
    tagInput.addEventListener('keydown', handleTagInputKeydown);
    tagInputContainer.addEventListener('click', function() {
        tagInput.focus();
    });

    editForm.addEventListener('submit', handleSubmit);
    deleteBtn.addEventListener('click', showDeleteModal);
    deleteCancelBtn.addEventListener('click', hideDeleteModal);
    deleteConfirmBtn.addEventListener('click', handleDelete);

    // 모달 오버레이 클릭 시 닫기
    deleteModal.addEventListener('click', function(e) {
        if(e.target === deleteModal) {
            hideDeleteModal();
        }
    });

    // ESC 키로 모달 닫기
    document.addEventListener('keydown', function(e) {
        if(e.key === 'Escape' && deleteModal.classList.contains('active')) {
            hideDeleteModal();
        }
    });

    // 입력 시 에러 초기화
    kaomojiInput.addEventListener('input', function() {
        hideErrorMsg(kaomojiError);
    });
});

// ===========================================
// 데이터 로드
// ===========================================

/**
 * Kaomoji 데이터 로드
 */
async function loadKaomojiData() {
    try {
        const response = await KaomojiAPI.getById(kaomojiId);
        originalData = response.data;

        // 폼에 데이터 채우기
        kaomojiInput.value = originalData.contents;
        tags = [...originalData.tags];
        renderTags();

        // UI 표시
        showContent();

    } catch (error) {
        showError();
    }
}

// ===========================================
// 태그 관리
// ===========================================

function handleTagInputKeydown(e) {
    // 한글 IME 조합 중일 때는 무시 (한글 이중 입력 방지)
    if(e.isComposing || e.keyCode === 229) {
        return;
    }

    const value = tagInput.value.trim().toLowerCase();

    if(e.key === 'Enter' || e.key === ',') {
        e.preventDefault();
        
        if(value && !tags.includes(value)) {
            addTag(value);
            tagInput.value = '';
            hideErrorMsg(tagError);
        } else if(tags.includes(value)) {
            showErrorMsg(tagError, '이미 추가된 태그입니다');
        }
    }

    if(e.key === 'Backspace' && !tagInput.value && tags.length > 0) {
        removeTag(tags[tags.length - 1]);
    }
}

function addTag(tagName) {
    tags.push(tagName);
    renderTags();
}

function removeTag(tagName) {
    tags = tags.filter(t => t !== tagName);
    renderTags();
}

function renderTags() {
    tagList.innerHTML = tags.map(tag => `
        <span class="tag tag--removable">
            #${escapeHtml(tag)}
            <span class="tag__remove" data-tag="${escapeHtml(tag)}" title="삭제">×</span>
        </span>
    `).join('');

    tagList.querySelectorAll('.tag__remove').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            removeTag(this.dataset.tag);
        });
    });
}

// ===========================================
// 폼 제출 (수정)
// ===========================================

async function handleSubmit(e) {
    e.preventDefault();

    if(!validateForm()) {
        return;
    }

    const contents = kaomojiInput.value.trim();

    submitBtn.disabled = true;
    submitBtn.textContent = '수정 중...';

    try {
        await KaomojiAPI.update(kaomojiId, contents, password, tags);
        
        // 비밀번호 정리
        sessionStorage.removeItem('edit_password');
        
        showToast('수정되었습니다! ✨', 'success');
        
        setTimeout(function() {
            window.location.href = '/';
        }, 1000);

    } catch (error) {
        if(error.message.includes('이미 등록된')) {
            showErrorMsg(kaomojiError, error.message);
        } else if(error.message.includes('비밀번호')) {
            showToast('비밀번호가 일치하지 않습니다.', 'error');
            setTimeout(function() {
                sessionStorage.removeItem('edit_password');
                window.location.href = '/';
            }, 1500);
        } else {
            showToast(error.message || '수정에 실패했습니다.', 'error');
        }

        submitBtn.disabled = false;
        submitBtn.textContent = '수정하기';
    }
}

function validateForm() {
    let isValid = true;

    const contents = kaomojiInput.value.trim();
    if(!contents) {
        showErrorMsg(kaomojiError, '감정표현을 입력하세요.');
        isValid = false;
    }

    if(tags.length === 0) {
        showErrorMsg(tagError, '태그를 최소 1개 이상 입력하세요.');
        isValid = false;
    }

    return isValid;
}

// ===========================================
// 삭제
// ===========================================

function showDeleteModal() {
    deleteModal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function hideDeleteModal() {
    deleteModal.classList.remove('active');
    document.body.style.overflow = '';
}

async function handleDelete() {
    deleteConfirmBtn.disabled = true;
    deleteConfirmBtn.textContent = '삭제 중...';

    try {
        await KaomojiAPI.delete(kaomojiId, password);
        
        // 비밀번호 정리
        sessionStorage.removeItem('edit_password');
        
        hideDeleteModal();
        showToast('삭제되었습니다.', 'success');
        
        setTimeout(function() {
            window.location.href = '/';
        }, 1000);

    } catch (error) {
        hideDeleteModal();

        if(error.message.includes('비밀번호')) {
            showToast('비밀번호가 일치하지 않습니다.', 'error');
            setTimeout(function() {
                sessionStorage.removeItem('edit_password');
                window.location.href = '/';
            }, 1500);
        } else {
            showToast(error.message || '삭제에 실패했습니다.', 'error');
        }

        deleteConfirmBtn.disabled = false;
        deleteConfirmBtn.textContent = '삭제';
    }
}

// ===========================================
// UI 상태 관리
// ===========================================

function showContent() {
    loadingEl.style.display = 'none';
    errorStateEl.style.display = 'none';
    editContentEl.style.display = 'block';
}

function showError() {
    loadingEl.style.display = 'none';
    editContentEl.style.display = 'none';
    errorStateEl.style.display = 'block';
}

function showErrorMsg(el, message) {
    el.textContent = message;
    el.style.display = 'block';
}

function hideErrorMsg(el) {
    el.style.display = 'none';
}

// ===========================================
// 유틸리티
// ===========================================

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

