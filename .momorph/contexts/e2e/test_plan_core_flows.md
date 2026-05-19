# Test Plan: SAA 2025 Core Flows

**Source**: MoMorph test cases + Flutter implementation  
**Component**: iOS mobile (`app/app/`)  
**Created**: 2026-05-19

---

## TC_LOGIN_MOCK_001 — Mock Google login → MainTab

**Test ID**: `TC_LOGIN_FUN_007` (MoMorph) / `IT-login-001` (integration)  
**Type**: Positive | **Priority**: High

**Preconditions**: `SAA_AUTH_MOCK=true`, fresh install or logged out

**Steps**:
1. Launch app → Splash → Login
2. Tap `LOGIN With Google`
3. Wait for navigation

**Expected**: Bottom navigation visible (4 tabs); session stored (relaunch skips login)

**Automation**: `integration_test/login_flow_test.dart`

---

## TC_SEARCH_404_001 — Search no results → Not Found

**Test ID**: `TC_NOTFOUND_FUN_003` (adapted) / `IT-search-404-001`  
**Type**: Negative | **Priority**: High

**Preconditions**: Logged in, mock API

**Steps**:
1. Open Kudos tab → Search
2. Enter query with no matches (e.g. `zzzznonexistent999`)
3. Wait debounce 450ms

**Expected**: Not Found screen with PNG illustration and "Về trang chủ"

**Automation**: `integration_test/search_not_found_test.dart`

---

## TC_SB_OPEN_001 — Secret Box open → standby → closed

**Test ID**: `TC_SB_FUN_001`, `TC_SB_FUN_002`  
**Type**: Positive | **Priority**: High

**Preconditions**: Logged in, Awards → Secret Box, unopened > 0

**Steps**:
1. Tap box image
2. Wait opening animation
3. Verify standby copy + prize label
4. Tap `Tiếp tục`

**Expected**: Returns to closed; counter decremented

**Automation**: `integration_test/secret_box_flow_test.dart`

---

## TC_ERR_ROUTE_001 — Unknown route → 404

**Type**: Negative | **Priority**: Medium

**Steps**: Navigate to invalid stacked route (dev only)

**Expected**: `NotFoundState` via `saaOnGenerateRoute`

**Automation**: Manual / future web E2E

---

## Summary

| Flow | Tests | Flutter | Playwright design |
|------|-------|---------|-------------------|
| Login | 1 | Yes | Yes |
| Search 404 | 1 | Yes | Yes |
| Secret Box | 1 | Yes | Yes |
| Errors | 1 | Partial | Yes |

**Next**: `/momorph.writee2e` when `APP_BASE_URL` web build exists → `e2e/tests/app/`
