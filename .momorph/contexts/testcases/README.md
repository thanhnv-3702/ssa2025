# SAA 2025 — Test Cases (MoMorph)

**File key:** `9ypp4enmFmdK3YAFJLIu6C`  
**Sync:** MoMorph server via MCP `download_test_cases` / `upload_test_cases`

## Coverage

| Screen | screen_id | TC count | Local CSV | Status |
|--------|-----------|----------|-----------|--------|
| [iOS] Login | `8HGlvYGJWq` | 20 | `csv/login_8HGlvYGJWq.csv` | On server |
| [iOS] Home | `OuH1BUTYT0` | 20 | — | On server |
| [iOS] Sun*Kudos | `fO0Kt19sZZ` | 39 | — | On server |
| [iOS] Notifications | `_b68CBWKl5` | 3 | — | **Uploaded P5** |
| [iOS] Viết Kudo | `7fFAb-K35a` | 2+ | — | **Updated P6** |
| [iOS] Profile bản thân | `hSH7L8doXB` | 1 | — | **Uploaded P6** |
| [iOS] Open secret box | `kQk65hSYF2` | 5 | `csv/secret_box_kQk65hSYF2.csv` | **Uploaded P3** |
| [iOS] Not Found | `sn2mdavs1a` | 10 | `csv/not_found_sn2mdavs1a.csv` | On server |
| [iOS] Access denied | `k-7zJk2B7s` | 3 | — | **Uploaded P4** |

## Upload / download

```bash
# Download CSV (MCP or MoMorph UI)
momorph upload testcases path/to/file.csv --screen-id={screenID}

# Regenerate local copy (agent / MCP)
# download_test_cases screen_id=8HGlvYGJWq format=csv
```

## Flutter mapping

| Integration test | MoMorph TC (sample) |
|------------------|---------------------|
| `integration_test/login_flow_test.dart` | TC_LOGIN_FUN_007, TC_LOGIN_FUN_012 |
| `integration_test/secret_box_flow_test.dart` | TC_SB_FUN_001–003 |
| `integration_test/search_not_found_test.dart` | TC_NOTFOUND_FUN_003 (app: search empty → 404) |

## E2E Playwright

Atomic plans: `.momorph/contexts/e2e/test_plan_core_flows.md`  
Design smoke: `e2e/tests/design/`  
App (future web): `e2e/tests/app/README.md`
