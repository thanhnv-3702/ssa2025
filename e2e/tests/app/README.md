# App E2E (future web / staging)

Playwright tests against a **deployed SAA web build** are not enabled yet — the product is **Flutter iOS**.

## When `APP_BASE_URL` is available

1. Set in `e2e/.env`:
   ```env
   APP_BASE_URL=https://saa2025-staging.example.com
   SAA_AUTH_MOCK=true
   ```

2. Add specs under `e2e/tests/app/`:
   - `login.spec.ts` — maps `TC_LOGIN_FUN_007`
   - `kudos-hub.spec.ts` — maps `TC_IOS_KUDOS_ACC_002`
   - `secret-box.spec.ts` — maps `TC_SB_FUN_001`

3. Run:
   ```bash
   npx playwright test --project=app-chromium
   ```

## Until then

Use **Flutter integration tests**:

```bash
cd app/app && flutter test integration_test/
```

Design regression: `npm test` in `e2e/` (MoMorph URLs).
