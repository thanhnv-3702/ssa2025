# SAA 2025 — TestFlight & release checklist

## Pre-build

- [ ] `SAA_AUTH_MOCK=false` / `SAA_API_MOCK=false` in `.stag.env` verified on device
- [ ] `GOOGLE_SERVER_CLIENT_ID` set (iOS URL scheme + Google Cloud)
- [ ] `BASE_URL` points to staging/production
- [ ] `./scripts/staging_smoke.sh` passes on VPN
- [ ] `flutter analyze` + `flutter test` green
- [ ] `cd e2e && npm test` design specs pass

## iOS build

```bash
cd app/app
flutter build ipa --dart-define=ENV=stag
# or Xcode Archive → Distribute → TestFlight
```

- [ ] Bundle ID / signing team correct
- [ ] Push notifications entitlement (FCM) if required
- [ ] Privacy manifest / App Store privacy labels

## Functional smoke (TestFlight)

| # | Flow | Pass |
|---|------|------|
| 1 | Cold start → Login Google → MainTab | |
| 2 | Kudos hub loads (API or mock) | |
| 3 | Write Kudo → Preview → Send | |
| 4 | Search Sunner → profile other | |
| 5 | Notifications list + mark read | |
| 6 | Secret Box open flow | |
| 7 | 404 search / Access denied route | |
| 8 | Language VN / EN / JA on Login + errors | |

## API contract (staging)

| Endpoint | Used by |
|----------|---------|
| POST `/login` | Auth |
| GET `/kudos/hub` | Kudos tab |
| POST `/kudos` | Write Kudo |
| GET `/sunner/profile` | Profile tab |
| GET `/sunner/kudos` | Profile kudos list |
| GET `/notifications` | Bell icon |
| GET `/awards` | Awards tab |

## Post-upload

- [ ] TestFlight internal group invited
- [ ] Release notes (VN + EN)
- [ ] MoMorph test cases executed sample on build

## Known limits (this build)

- Image upload on Write Kudo: count only (`image_count`), no multipart yet
- Mark-all-read notifications: client-side on mock; BE PATCH optional
