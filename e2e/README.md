# SAA 2025 — E2E (Playwright)

Playwright project theo MoMorph `momorph.setupe2e` — kiểm tra **MoMorph design screens** và sẵn sàng mở rộng khi có bản web/staging.

## Phạm vi

| Layer | Tool | Thư mục |
|-------|------|---------|
| MoMorph design QA | Playwright | `e2e/tests/design/` |
| Flutter mobile smoke | `integration_test` | `app/app/integration_test/` |

## Cài đặt

```bash
cd e2e
cp .env.example .env
npm install
npx playwright install chromium
```

## Chạy test

```bash
npm test
npm run test:ui      # UI mode
npm run report       # HTML report
```

## Màn hình được cover

- Login `8HGlvYGJWq`
- Kudos `fO0Kt19sZZ`
- Secret Box `kQk65hSYF2`
- Not Found / Access denied

Screen IDs: `constants/screens.ts` — đồng bộ với `.momorph/contexts/SCREENFLOW.md`.

## Flutter on-device

```bash
cd app/app
flutter test integration_test/
```

Yêu cầu emulator/simulator; app dùng `SAA_AUTH_MOCK=true` để login không cần Google thật.

## P5 — Notifications & CI

- Flutter: `NotificationsRepository` + `NotificationBadgeService`
- GitHub Actions: `.github/workflows/ci.yml`
- Design spec: `tests/design/notifications.spec.ts`

## P3 — Test cases & mapping

| Artifact | Path |
|----------|------|
| TC index + CSV | `.momorph/contexts/testcases/` |
| Atomic E2E plan | `.momorph/contexts/e2e/test_plan_core_flows.md` |
| App E2E (web) | `tests/app/` — bật khi có `APP_BASE_URL` |

**MoMorph:** Secret Box `kQk65hSYF2` — 5 TC uploaded P3.

## Tài liệu MoMorph

- `.momorph/guidelines/e2e/guides/README_VN.md`
- `/momorph.createtestcases` — sinh test case CSV từ Figma
