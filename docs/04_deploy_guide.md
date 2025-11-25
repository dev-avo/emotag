# emotag 배포 가이드

Cloudflare Pages + D1을 사용한 Git 연동 배포 가이드

---

## 사전 준비

1. [Cloudflare 계정](https://dash.cloudflare.com/) 생성
2. [GitHub 계정](https://github.com/) 생성
3. Node.js 18+ 설치
4. Git 설치

---

## 1단계: 의존성 설치

```bash
npm install
```

---

## 2단계: Cloudflare 로그인

```bash
npx wrangler login
```

브라우저가 열리면 Cloudflare 계정으로 로그인합니다.

---

## 3단계: D1 데이터베이스 생성

```bash
npm run db:create
# 또는
npx wrangler d1 create emotag-db
```

**출력 예시:**
```
✅ Successfully created DB 'emotag-db'
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

---

## 4단계: wrangler.toml 업데이트

출력된 `database_id`를 `wrangler.toml`에 복사합니다:

```toml
[[d1_databases]]
binding = "EMOTAG_DB"
database_name = "emotag-db"
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

---

## 5단계: 스키마 적용

```bash
# 프로덕션 D1에 스키마 적용
npm run db:migrate
```

---

## 6단계: 시드 데이터 (선택)

```bash
npx wrangler d1 execute emotag-db --file=seed.sql
```

---

## 7단계: Git 저장소 생성

### GitHub에서 새 저장소 생성

1. GitHub에서 `emotag` 저장소 생성 (README 없이)
2. 로컬에서 Git 초기화 및 푸시:

```bash
git init
git add .
git commit -m "Initial commit: emotag project setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/emotag.git
git push -u origin main
```

---

## 8단계: Cloudflare Pages 연동

### 방법 1: Cloudflare 대시보드 (권장)

1. [Cloudflare Dashboard](https://dash.cloudflare.com/) 접속
2. **Workers & Pages** 클릭
3. **Create application** → **Pages** 탭 선택
4. **Connect to Git** 클릭
5. GitHub 계정 연결 후 `emotag` 저장소 선택
6. 빌드 설정:

| 설정 | 값 |
|------|-----|
| Framework preset | None |
| Build command | (비워두기) |
| Build output directory | `public` |

7. **Environment variables** 섹션에서:
   - 없음 (D1은 자동 바인딩)

8. **Save and Deploy** 클릭

### 방법 2: Wrangler CLI

```bash
npx wrangler pages project create emotag
npx wrangler pages deploy public
```

---

## 9단계: D1 바인딩 설정

Cloudflare Pages 프로젝트에 D1을 연결합니다:

1. Cloudflare Dashboard → **Workers & Pages** → **emotag** 프로젝트
2. **Settings** → **Functions** 탭
3. **D1 database bindings** 섹션
4. **Add binding** 클릭:
   - Variable name: `EMOTAG_DB`
   - D1 database: `emotag-db` 선택
5. **Save** 클릭

> ⚠️ **중요**: 바인딩 설정 후 재배포가 필요할 수 있습니다.

---

## 10단계: 배포 확인

배포가 완료되면 URL이 생성됩니다:

```
https://emotag.pages.dev
```

또는 커스텀 도메인을 연결할 수 있습니다.

---

## 자동 배포

GitHub에 푸시하면 자동으로 배포됩니다:

```bash
git add .
git commit -m "Update feature"
git push
```

Cloudflare Pages가 자동으로 빌드 및 배포합니다.

---

## 유용한 명령어

| 명령어 | 설명 |
|--------|------|
| `npm run dev` | 로컬 개발 서버 |
| `npm run deploy` | 수동 배포 |
| `npm run db:migrate` | 프로덕션 DB 마이그레이션 |
| `npm run db:migrate:local` | 로컬 DB 마이그레이션 |

---

## 문제 해결

### "D1 binding not found" 오류
- Cloudflare Pages 설정에서 D1 바인딩이 올바르게 설정되었는지 확인
- 바인딩 이름이 `EMOTAG_DB`인지 확인

### 빌드 실패
- `public` 폴더에 정적 파일이 있는지 확인
- `functions` 폴더의 JavaScript 문법 오류 확인

### 로컬에서 API 오류
- `npm run db:migrate:local` 실행하여 로컬 D1에 스키마 적용

---

## 환경 구조

```
Production:
  └── Cloudflare Pages (https://emotag.pages.dev)
        ├── Static Files (public/)
        ├── Functions (functions/)
        └── D1 Database (emotag-db)

Local Development:
  └── Wrangler Dev Server (http://localhost:8788)
        ├── Static Files (public/)
        ├── Functions (functions/)
        └── Local D1 (.wrangler/)
```

