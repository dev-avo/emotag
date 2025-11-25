# Cloudflare D1 데이터베이스 설정 가이드

## 사전 준비

1. [Cloudflare 계정](https://dash.cloudflare.com/) 생성
2. Node.js 18+ 설치
3. Wrangler CLI 설치

```bash
npm install
```

---

## 1단계: Cloudflare 로그인

```bash
npx wrangler login
```

브라우저가 열리면 Cloudflare 계정으로 로그인하고 권한을 승인합니다.

---

## 2단계: D1 데이터베이스 생성

```bash
npm run db:create
# 또는
npx wrangler d1 create emotag-db
```

**출력 예시:**
```
✅ Successfully created DB 'emotag-db'

[[d1_databases]]
binding = "EMOTAG_DB"
database_name = "emotag-db"
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

---

## 3단계: wrangler.toml 업데이트

위에서 출력된 `database_id`를 `wrangler.toml`에 복사합니다:

```toml
[[d1_databases]]
binding = "EMOTAG_DB"
database_name = "emotag-db"
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # ← 여기에 붙여넣기
```

---

## 4단계: 스키마 적용

### 로컬 개발용 (로컬 D1)
```bash
npm run db:migrate:local
# 또는
npx wrangler d1 execute emotag-db --local --file=schema.sql
```

### 프로덕션용 (원격 D1)
```bash
npm run db:migrate
# 또는
npx wrangler d1 execute emotag-db --file=schema.sql
```

---

## 5단계: 로컬 개발 서버 실행

```bash
npm run dev
```

`http://localhost:8788`에서 개발 서버가 실행됩니다.

---

## 유용한 명령어

| 명령어 | 설명 |
|--------|------|
| `npx wrangler d1 list` | 모든 D1 데이터베이스 목록 |
| `npx wrangler d1 info emotag-db` | DB 정보 확인 |
| `npx wrangler d1 execute emotag-db --command "SELECT * FROM kaomoji"` | SQL 실행 |
| `npx wrangler d1 execute emotag-db --local --command "..."` | 로컬 DB에 SQL 실행 |

---

## 문제 해결

### "database_id not found" 오류
- `wrangler.toml`의 `database_id`가 올바른지 확인

### 로컬에서 테이블이 없다는 오류
- `npm run db:migrate:local` 실행하여 로컬 DB에 스키마 적용

### 권한 오류
- `npx wrangler login`으로 재로그인

