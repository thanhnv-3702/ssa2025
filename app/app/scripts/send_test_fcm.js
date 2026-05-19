/**
 * Send a test FCM notification to a single Android device token (no iOS / APNs).
 *
 * Usage:
 *   1. Install: npm install firebase-admin
 *   2. Run: node scripts/send_test_fcm.js <path-to-service-account.json> <FCM_TOKEN>
 *
 * Example:
 *   node scripts/send_test_fcm.js /Users/neon/Downloads/ehrhealthcaresystem-firebase-adminsdk-fbsvc-a02a15f4bf.json "duvzWDriFUFGt3S7vk5YDW:APA91b..."
 */

const admin = require('firebase-admin');
const path = require('path');

const serviceAccountPath = process.argv[2];
const fcmToken = process.argv[3];

if (!serviceAccountPath || !fcmToken) {
  console.error('Usage: node send_test_fcm.js <path-to-service-account.json> <FCM_TOKEN>');
  process.exit(1);
}

const resolvedPath = path.isAbsolute(serviceAccountPath)
  ? serviceAccountPath
  : path.resolve(process.cwd(), serviceAccountPath);
const serviceAccount = require(resolvedPath);

if (!admin.apps.length) {
  admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
}

const message = {
  notification: {
    title: 'Test from script',
    body: 'If you see this, FCM is working.',
  },
  data: {
    test: 'true',
  },
  token: fcmToken,
  android: {
    priority: 'high',
  },
};

admin
  .messaging()
  .send(message)
  .then((response) => {
    console.log('Successfully sent:', response);
  })
  .catch((err) => {
    console.error('Error sending message:', err);
    process.exit(1);
  });
