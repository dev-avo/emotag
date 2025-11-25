# PRD: emotag

## 1. 개요
* **피처명:** emotag - Kaomoji 검색 및 공유 서비스
* **목표:** 사용자가 태그 기반으로 Kaomoji를 쉽게 검색하고, 복사하여 사용할 수 있는 공개 웹 서비스 제공. 누구나 Kaomoji를 등록할 수 있으며, 비밀번호 기반의 간단한 관리 시스템 제공.

## 2. 사용자 스토리
* "일반 사용자로서, 원하는 감정/상황에 맞는 Kaomoji를 태그로 검색하고 클릭 한 번으로 복사하고 싶다."
* "기여자로서, 새로운 Kaomoji를 태그와 함께 등록하고, 필요시 내가 등록한 Kaomoji를 수정/삭제하고 싶다."
* "사용자로서, 랜덤 버튼을 눌러 재미있는 Kaomoji를 발견하고 싶다."

## 3. 기능 요구사항 (Functional Requirements)

### 3.1 홈 페이지
* 태그 검색창 (자동완성 또는 즉시 검색)
* Kaomoji 등록 버튼
* 랜덤 Kaomoji 버튼
* 검색 결과 Kaomoji 목록 표시

### 3.2 Kaomoji 검색
* 태그명으로 Kaomoji 검색
* 검색 결과를 목록 페이지에서 카드/리스트 형태로 표시

### 3.3 Kaomoji 목록 페이지
* 검색된 Kaomoji들을 카드 또는 목록 형태로 표시
* 각 Kaomoji 항목 구성:
  - **Kaomoji 텍스트**: 이모티콘 표시 (클릭 시 복사)
  - **태그**: 해당 Kaomoji의 태그 뱃지들
  - **복사 버튼**: 클릭 시 클립보드에 복사 + 복사 완료 피드백
  - **수정 버튼**: 클릭 시 비밀번호 입력 모달 → 인증 성공 시 수정 페이지로 이동

### 3.4 Kaomoji 등록
* 필수 입력: Kaomoji 문자열, 비밀번호, 태그(1개 이상)
* 중복 검사: 동일한 Kaomoji가 이미 존재하면 등록 거부
* 등록 성공 시 알림 메시지

### 3.5 Kaomoji 수정/삭제
* 비밀번호 입력 시에만 수정/삭제 가능
* 삭제는 Soft Delete (status = -1)
* 수정: Kaomoji 문자열, 태그 변경 가능

### 3.6 랜덤 기능
* 랜덤 버튼 클릭 시 활성 상태(status != -1)인 Kaomoji 중 하나를 무작위로 표시

## 4. 비-목표 (Non-Goals)
* 사용자 회원가입/로그인 시스템 (비밀번호는 Kaomoji별로 개별 관리)
* Kaomoji 좋아요/인기 순위 시스템
* 관리자 대시보드
* 다국어 지원
* PWA/모바일 앱

## 5. 디자인 및 UI/UX 고려사항

### 5.1 페이지 구조
```
/                 - 홈 (검색창, 등록 버튼, 랜덤 버튼, 검색 결과 목록)
/register         - Kaomoji 등록 페이지
/edit/:id         - Kaomoji 수정 페이지 (비밀번호 인증 후)
```

### 5.2 UI 요소
* **홈**: 중앙 정렬된 검색창, 하단에 등록/랜덤 버튼, 검색 결과 목록 영역
* **검색 결과 목록**: 카드 또는 리스트 형태
* **Kaomoji 카드 구성**:
  ```
  ┌─────────────────────────────────────────────────┐
  │ (´･ω･`)  │  #sad #cute  │  📋 복사  │  ✏️ 수정  │
  └─────────────────────────────────────────────────┘
  ```
  - Kaomoji 텍스트 (클릭 시 복사)
  - 태그 뱃지 (클릭 시 해당 태그로 검색)
  - 복사 버튼
  - 수정 버튼 (클릭 → 비밀번호 모달 → 인증 후 수정 페이지 이동)
* **비밀번호 모달**: 수정 버튼 클릭 시 팝업, 비밀번호 입력 필드 + 확인/취소 버튼
* **복사 피드백**: 토스트 메시지 또는 시각적 효과 ("복사되었습니다!")

### 5.3 반응형
* 모바일/데스크톱 모두 지원

## 6. 기술적 고려사항

### 6.1 기술 스택
* **Frontend**: HTML, CSS, JavaScript (Vanilla)
* **Backend**: Cloudflare Pages Functions (Workers)
* **Database**: Cloudflare D1 (SQLite)
* **배포**: Cloudflare Pages (Git 연동)

### 6.2 데이터베이스 스키마

```sql
-- kaomojis 테이블
CREATE TABLE kaomoji (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contents TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    status INTEGER DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tag 테이블
CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- kaomoji_tag 테이블 (다대다 관계)
CREATE TABLE kaomoji_tag (
    kaomoji_id INTEGER,
    tag_id INTEGER,
    PRIMARY KEY (kaomoji_id, tag_id),
    FOREIGN KEY (kaomoji_id) REFERENCES kaomoji(id),
    FOREIGN KEY (tag_id) REFERENCES tag(id)
);
```

### 6.3 API 엔드포인트

| Method | Endpoint | 설명 |
|--------|----------|------|
| GET | `/api/kaomoji` | 전체 목록 조회 (status=1) |
| GET | `/api/kaomoji/search?tag=` | 태그로 검색 |
| GET | `/api/kaomoji/random` | 랜덤 1개 조회 |
| POST | `/api/kaomoji` | 새 Kaomoji 등록 |
| PUT | `/api/kaomoji/:id` | Kaomoji 수정 (비밀번호 필요) |
| DELETE | `/api/kaomoji/:id` | Kaomoji 삭제 (비밀번호 필요, soft delete) |
| POST | `/api/kaomoji/:id/verify` | 비밀번호 검증 |
| GET | `/api/tag` | 전체 태그 목록 |

### 6.4 프로젝트 구조
```
emotag/
├── public/
│   ├── index.html
│   ├── register.html
│   ├── edit.html
│   ├── css/
│   │   └── style.css
│   └── js/
│       ├── main.js
│       ├── register.js
│       └── edit.js
├── functions/
│   └── api/
│       ├── kaomoji/
│       │   ├── index.js
│       │   ├── [id].js
│       │   ├── random.js
│       │   └── search.js
│       └── tag/
│           └── index.js
├── schema.sql
├── wrangler.toml
└── package.json
```