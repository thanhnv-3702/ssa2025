#!/usr/bin/env python3
"""Send a test FCM notification to Android only (HTTP v1) — no Node/npm, no iOS/APNs.

Usage:
  1) One-time: python3 -m venv .venv && .venv/bin/pip install firebase-admin
  2) Run: .venv/bin/python send_test_fcm.py <path-to-service-account.json> <FCM_TOKEN>

Example:
  app/scripts/.venv/bin/python app/scripts/send_test_fcm.py \\
    ~/Downloads/ehrhealthcaresystem-firebase-adminsdk-fbsvc-a02a15f4bf.json \\
    "duvzWDriFUFGt3S7vk5YDW:APA91b..."
"""

import sys
from pathlib import Path

import firebase_admin
from firebase_admin import credentials, messaging


def main() -> None:
    if len(sys.argv) != 3:
        print(
            'Usage: python send_test_fcm.py <path-to-service-account.json> <FCM_TOKEN>',
            file=sys.stderr,
        )
        sys.exit(1)

    sa_path = Path(sys.argv[1]).expanduser().resolve()
    fcm_token = sys.argv[2]

    if not sa_path.is_file():
        print(f'Service account file not found: {sa_path}', file=sys.stderr)
        sys.exit(1)

    cred = credentials.Certificate(str(sa_path))
    if not firebase_admin._apps:
        firebase_admin.initialize_app(cred)

    message = messaging.Message(
        notification=messaging.Notification(
            title='Test from script',
            body='If you see this, FCM is working.',
        ),
        data={'test': 'true'},
        token=fcm_token,
        android=messaging.AndroidConfig(priority='high'),
    )

    try:
        mid = messaging.send(message)
        print('Successfully sent:', mid)
    except Exception as e:
        print('Error sending message:', e, file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
