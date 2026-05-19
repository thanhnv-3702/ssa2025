# Flutter plugins (fixes PlatformException channel-error when minifyEnabled true)
-keep class io.flutter.plugins.** { *; }
-if class * implements io.flutter.embedding.engine.plugins.FlutterPlugin
-keep,allowshrinking,allowobfuscation class <1>

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Messaging (avoid "Firebase Messaging component is not present" when minified)
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.components.ComponentRegistrar { *; }
