# [iOS] Notifications — `_b68CBWKl5`

**MoMorph:** 3 test cases (uploaded P5)  
**Flutter:** `lib/pages/notification/`

## API

`GET /apis/default/api/notifications` → `NotificationsJsonParser`

## Automated

| TC_ID | Tool |
|-------|------|
| TC_NOTIF_ACC_001 | `integration_test/notifications_list_test.dart` |
| TC_NOTIF_FUN_001–002 | Manual / mock mark-read |

## vs Secret Box

Secret Box feed = in-app activity (`Hoạt động trong app`).  
Notifications = bell icon → `NotificationListState`.
