/**
 * emotag - 등록 페이지 스크립트
 */

// DOM 요소
const addForm = document.getElementById('add-form');
const kaomojiInput = document.getElementById('kaomoji-input');
const tagInputContainer = document.getElementById('tag-input-container');
const tagInput = document.getElementById('tag-input');
const tagList = document.getElementById('tag-list');
const passwordInput = document.getElementById('password-input');
const passwordConfirmInput = document.getElementById('password-confirm-input');
const submitBtn = document.getElementById('submit-btn');

// 에러 요소
const kaomojiError = document.getElementById('kaomoji-error');
const tagError = document.getElementById('tag-error');
const passwordError = document.getElementById('password-error');
const passwordConfirmError = document.getElementById('password-confirm-error');

// 상태
let tags = [];

// ===========================================
// 초기화
// ===========================================

document.addEventListener('DOMContentLoaded', function() {
    // 태그 입력 이벤트
    tagInput.addEventListener('keydown', handleTagInputKeydown);
    tagInputContainer.addEventListener('click', function() {
        tagInput.focus();
    });

    // 폼 제출
    addForm.addEventListener('submit', handleSubmit);

    // 입력 시 에러 초기화
    kaomojiInput.addEventListener('input', function() {
        hideError(kaomojiError);
    });
    passwordInput.addEventListener('input', function() {
        hideError(passwordError);
    });
    passwordConfirmInput.addEventListener('input', function() {
        hideError(passwordConfirmError);
    });
});

// ===========================================
// 태그 관리
// ===========================================

/**
 * 태그 입력 키다운 핸들러
 */
function handleTagInputKeydown(e) {
    const value = tagInput.value.trim().toLowerCase();

    // Enter 또는 쉼표로 태그 추가
    if(e.key === 'Enter' || e.key === ',') {
        e.preventDefault();
        
        if(value && !tags.includes(value)) {
            addTag(value);
            tagInput.value = '';
            hideError(tagError);
        } else if(tags.includes(value)) {
            showError(tagError, '이미 추가된 태그입니다');
        }
    }

    // Backspace로 마지막 태그 삭제
    if(e.key === 'Backspace' && !tagInput.value && tags.length > 0) {
        removeTag(tags[tags.length - 1]);
    }
}

/**
 * 태그 추가
 */
function addTag(tagName) {
    tags.push(tagName);
    renderTags();
}

/**
 * 태그 삭제
 */
function removeTag(tagName) {
    tags = tags.filter(t => t !== tagName);
    renderTags();
}

/**
 * 태그 목록 렌더링
 */
function renderTags() {
    tagList.innerHTML = tags.map(tag => `
        <span class="tag tag--removable">
            #${escapeHtml(tag)}
            <span class="tag__remove" data-tag="${escapeHtml(tag)}" title="삭제">×</span>
        </span>
    `).join('');

    // 삭제 버튼 이벤트
    tagList.querySelectorAll('.tag__remove').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.stopPropagation();
            removeTag(this.dataset.tag);
        });
    });
}

// ===========================================
// 폼 제출
// ===========================================

/**
 * 폼 제출 핸들러
 */
async function handleSubmit(e) {
    e.preventDefault();

    // 유효성 검사
    if(!validateForm()) {
        return;
    }

    const contents = kaomojiInput.value.trim();
    const password = passwordInput.value;

    // 버튼 비활성화
    submitBtn.disabled = true;
    submitBtn.textContent = '등록 중...';

    try {
        await KaomojiAPI.create(contents, password, tags);
        
        showToast('감정표현이 등록되었습니다! 🎉', 'success');
        
        // 홈으로 이동
        setTimeout(function() {
            window.location.href = '/';
        }, 1000);

    } catch (error) {
        // 중복 에러 처리
        if(error.message.includes('이미 등록된')) {
            showError(kaomojiError, '이미 등록된 감정표현입니다.');
        } else {
            showToast(error.message || '등록에 실패했습니다.', 'error');
        }

        submitBtn.disabled = false;
        submitBtn.textContent = '등록하기';
    }
}

/**
 * 폼 유효성 검사
 */
function validateForm() {
    let isValid = true;

    // 카오모지 검사
    const contents = kaomojiInput.value.trim();
    if(!contents) {
        showError(kaomojiError, '감정표현을 입력하세요.');
        isValid = false;
    }

    // 태그 검사
    if(tags.length === 0) {
        showError(tagError, '태그를 최소 1개 이상 입력하세요.');
        isValid = false;
    }

    // 비밀번호 검사
    const password = passwordInput.value;
    if(!password) {
        showError(passwordError, '비밀번호를 입력하세요.');
        isValid = false;
    } else if(password.length < 4) {
        showError(passwordError, '비밀번호는 4자 이상이어야 합니다.');
        isValid = false;
    }

    // 비밀번호 확인 검사
    const passwordConfirm = passwordConfirmInput.value;
    if(password !== passwordConfirm) {
        showError(passwordConfirmError, '비밀번호가 일치하지 않습니다.');
        isValid = false;
    }

    return isValid;
}

// ===========================================
// 에러 표시
// ===========================================

function showError(el, message) {
    el.textContent = message;
    el.style.display = 'block';
}

function hideError(el) {
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
