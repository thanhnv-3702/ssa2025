# SAA 2025 — Staging & production

## Chọn môi trường

Flutter load env qua `Utils.setEnvPath(env)` trong `main.dart`:

| `ENV` / storage | File | Mục đích |
|-----------------|------|----------|
| `dev` (default) | `packages/https/.env` | Mock auth + mock API |
| `stag` / `staging` | `packages/https/.stag.env` | BE staging, không fallback mock |
| `prod` | `packages/https/.prod.env` | Production |

```bash
# Chạy staging (flutter run)
flutter run --dart-define=ENV=stag

# Hoặc lưu env trong secure storage keySelectedEnv = stag
```

## Biến quan trọng

| Biến | Dev | Staging |
|------|-----|---------|
| `SAA_AUTH_MOCK` | `true` | `false` |
| `SAA_API_MOCK` | `true` | `false` |
| `SAA_API_FALLBACK` | `false` | `false` |
| `GOOGLE_SERVER_CLIENT_ID` | empty | OAuth web client ID |
| `BASE_URL` | LAN / VPN | `https://inno.sun-asterisk.com/` |

## API contract (BE)

| Method | Path | App |
|--------|------|-----|
| POST | `/apis/default/api/login` | `AuthService` |
| GET | `/apis/default/api/kudos/hub` | `KudosRepositoryRemote` |
| GET | `/apis/default/api/awards` | `AwardsRepositoryRemote` |
| GET | `/apis/default/api/sunner/search?q=` | `SearchSunnerVm` |
| GET | `/apis/default/api/notifications` | `NotificationsRepositoryRemote` |
| POST | `/apis/default/api/kudos` | `WriteKudoVm.submitKudo` |
| GET | `/apis/default/api/sunner/profile?sunner_id=` | `SunnerProfileVm` |
| GET | `/apis/default/api/sunner/kudos?sunner_id=` | Profile kudos list |

**403** → `handleApiAccessDenied()` → Access Denied screen  
**Search empty** (staging) → Not Found (không dùng mock Sunner)

## Smoke check

```bash
./scripts/staging_smoke.sh
```

## Pixel / i18n (P4)

- Design tokens: `lib/theme/saa_design_tokens.dart` (`#FFE99E` accent)
- Error copy VN/EN/JA: `lib/pages/errors/saa_error_copy.dart`
- Secret Box feed ≠ Notifications (`Hoạt động trong app` vs `notification_list`)

## Checklist trước release

- [ ] `GOOGLE_SERVER_CLIENT_ID` trên staging
- [ ] `SAA_AUTH_MOCK=false` + login Google thật
- [ ] `SAA_API_MOCK=false` + hub/awards/search trả JSON đúng schema
- [ ] HTTP 403 từ BE → màn Access Denied
- [ ] `flutter test integration_test/` trên device staging build
