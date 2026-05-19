# [iOS] Open secret box — `kQk65hSYF2`

**MoMorph:** 5 test cases (uploaded P3)  
**Flutter:** `lib/pages/secret_box/`

## Automated

| TC_ID | Integration test |
|-------|------------------|
| TC_SB_FUN_001 | `secret_box_flow_test.dart` |
| TC_SB_FUN_002 | `secret_box_flow_test.dart` (Continue) |
| TC_SB_FUN_003 | Manual — set unopened to 0 |
| TC_SB_ACC_001 | `secret_box_flow_test.dart` (Awards → SECRET BOX) |
| TC_SB_GUI_001 | Design Playwright `secret-box.spec.ts` |

## Flow

`closed` → tap box → `opening` → `standby` → Tiếp tục → `closed`
