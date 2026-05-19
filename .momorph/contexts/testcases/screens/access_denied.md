# [iOS] Access denied — `k-7zJk2B7s`

**MoMorph:** 3 test cases (uploaded P4)  
**Flutter:** `lib/pages/errors/access_denied.dart`

## Triggers

- Route guard: `/admin`, `/protected`
- API: `ApiHttpException(403)` via `SaaApiGuard.handleIfForbidden`

## Automated

| TC_ID | Tool |
|-------|------|
| TC_403_ACC_001 | Manual / staging API |
| TC_403_FUN_001 | Manual |
| TC_403_GUI_001 | Playwright design spec |
