import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Required when FirebaseAppDelegateProxyEnabled is NO: forward APNs token to FCM.
    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // #region agent log
        let tokenStr = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("[DEBUG-dc2a8e][H2] APNs token received: \(tokenStr.prefix(20))... length=\(deviceToken.count)")
        // #endregion
        Messaging.messaging().apnsToken = deviceToken
    }

    // #region agent log
    override func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("[DEBUG-dc2a8e][H2][H4] APNs registration FAILED: \(error.localizedDescription)")
    }
    // #endregion
}
