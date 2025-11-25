# Task List: emotag

> PRD 기반 작업 목록 (Phase 2)

---

## 1. 프로젝트 초기 설정

- [x] 1.1 프로젝트 폴더 구조 생성 (`public/`, `functions/`, `public/css/`, `public/js/`)
- [x] 1.2 `package.json` 생성 (프로젝트 메타데이터, scripts 정의)
- [x] 1.3 `wrangler.toml` 설정 (Cloudflare Pages + D1 바인딩)
- [x] 1.4 `.gitignore` 파일 생성

---

## 2. 데이터베이스 설계 및 설정

- [x] 2.1 `schema.sql` 파일 작성 (kaomoji, tag, kaomoji_tag 테이블)
- [x] 2.2 Cloudflare D1 데이터베이스 생성 및 스키마 적용 가이드 문서 작성

---

## 3. Backend API 개발

### 3.1 Kaomoji API
- [x] 3.1.1 `functions/api/kaomoji/index.js` - GET (전체 목록 조회, status=1)
- [x] 3.1.2 `functions/api/kaomoji/index.js` - POST (새 Kaomoji 등록, 중복 검사, 비밀번호 해시)
- [x] 3.1.3 `functions/api/kaomoji/search.js` - GET (태그로 검색)
- [x] 3.1.4 `functions/api/kaomoji/random.js` - GET (랜덤 1개 조회)
- [x] 3.1.5 `functions/api/kaomoji/[id].js` - PUT (Kaomoji 수정, 비밀번호 검증)
- [x] 3.1.6 `functions/api/kaomoji/[id].js` - DELETE (Soft delete, status=-1)
- [x] 3.1.7 `functions/api/kaomoji/[id]/verify.js` - POST (비밀번호 검증)

### 3.2 Tag API
- [x] 3.2.1 `functions/api/tag/index.js` - GET (전체 태그 목록)

---

## 4. Frontend - 공통 요소

- [x] 4.1 `public/css/style.css` - 기본 스타일 및 CSS 변수 정의
- [x] 4.2 `public/css/style.css` - Kaomoji 카드 컴포넌트 스타일
- [x] 4.3 `public/css/style.css` - 버튼, 입력 필드, 태그 뱃지 스타일
- [x] 4.4 `public/css/style.css` - 모달(비밀번호 입력) 스타일
- [x] 4.5 `public/css/style.css` - 토스트 메시지 스타일
- [x] 4.6 `public/css/style.css` - 반응형 스타일 (모바일/데스크톱)
- [x] 4.7 `public/js/utils.js` - API 호출 유틸리티 함수
- [x] 4.8 `public/js/utils.js` - 클립보드 복사 함수
- [x] 4.9 `public/js/utils.js` - 토스트 메시지 표시 함수

---

## 5. Frontend - 홈 페이지 (index.html)

- [x] 5.1 `public/index.html` - HTML 구조 작성 (검색창, 버튼, 목록 영역)
- [x] 5.2 `public/js/main.js` - 페이지 로드 시 전체 Kaomoji 목록 불러오기
- [x] 5.3 `public/js/main.js` - 태그 검색 기능 구현
- [x] 5.4 `public/js/main.js` - Kaomoji 카드 렌더링 함수
- [x] 5.5 `public/js/main.js` - 복사 버튼 클릭 이벤트 (클립보드 복사 + 토스트)
- [x] 5.6 `public/js/main.js` - 랜덤 버튼 클릭 이벤트
- [x] 5.7 `public/js/main.js` - 수정 버튼 클릭 → 비밀번호 모달 표시
- [x] 5.8 `public/js/main.js` - 비밀번호 검증 후 수정 페이지 이동
- [x] 5.9 `public/js/main.js` - 태그 뱃지 클릭 시 해당 태그로 검색

---

## 6. Frontend - 등록 페이지 (register.html)

- [x] 6.1 `public/register.html` - HTML 구조 작성 (폼: Kaomoji, 비밀번호, 태그 입력)
- [x] 6.2 `public/js/register.js` - 태그 입력 UI (다중 태그 추가/삭제)
- [x] 6.3 `public/js/register.js` - 폼 유효성 검사
- [x] 6.4 `public/js/register.js` - 등록 API 호출 및 결과 처리 (성공/중복/에러)
- [x] 6.5 `public/js/register.js` - 등록 성공 시 홈으로 이동

---

## 7. Frontend - 수정 페이지 (edit.html)

- [x] 7.1 `public/edit.html` - HTML 구조 작성 (폼: Kaomoji, 태그 수정, 삭제 버튼)
- [x] 7.2 `public/js/edit.js` - URL 파라미터에서 ID 추출
- [x] 7.3 `public/js/edit.js` - 기존 Kaomoji 데이터 불러오기
- [x] 7.4 `public/js/edit.js` - 태그 수정 UI
- [x] 7.5 `public/js/edit.js` - 수정 API 호출 (비밀번호 포함)
- [x] 7.6 `public/js/edit.js` - 삭제 버튼 클릭 → 확인 모달 → 삭제 API 호출
- [x] 7.7 `public/js/edit.js` - 수정/삭제 성공 시 홈으로 이동

---

## 8. 배포 설정

- [ ] 8.1 Cloudflare D1 데이터베이스 생성 명령어 문서화
- [ ] 8.2 Git 저장소 초기화 및 Cloudflare Pages 연동 가이드
- [ ] 8.3 초기 시드 데이터 삽입 스크립트 작성 (선택)

---

## 작업 요약

| 카테고리 | 작업 수 |
|----------|---------|
| 1. 프로젝트 초기 설정 | 4 |
| 2. 데이터베이스 설정 | 2 |
| 3. Backend API | 8 |
| 4. Frontend 공통 | 9 |
| 5. 홈 페이지 | 9 |
| 6. 등록 페이지 | 5 |
| 7. 수정 페이지 | 7 |
| 8. 배포 설정 | 3 |
| **총계** | **47** |

---

**작업 목록 생성이 완료되었습니다. 이대로 진행할까요?**

