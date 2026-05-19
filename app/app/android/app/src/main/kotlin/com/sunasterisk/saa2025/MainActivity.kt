package com.sunasterisk.saa2025

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import vn.sun.bridge.Pigeon
import java.io.File

class MainActivity : FlutterFragmentActivity() {
    companion object {
        const val TAG = "MainActivity"
    }

    private var mEvent: EventSink? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Don't access flutterEngine here, use configureFlutterEngine instead
    }


    class AndroidAPI() : Pigeon.ReqApi {
        override fun request(request: Pigeon.Req): Pigeon.Res {
            Log.i(TAG, "AndroidAPI request: ${request.key ?: "N/A"}")
            val res = Pigeon.Res()

            res.key = "KEY_COMMON_RES"
            val rs = HashMap<Any, String>()
            rs["result"] = "true"
            res.data = rs as Map<Any, Any>?
            return res
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        Pigeon.ReqApi.setup(
            flutterEngine.dartExecutor.binaryMessenger, AndroidAPI()
        )
        EventChannel(flutterEngine.dartExecutor, "bridgeStream").setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventSink?) {
                    mEvent = events
                }

                override fun onCancel(arguments: Any?) {
                }
            }
        )
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.sunasterisk.saa2025/install_apk",
        ).setMethodCallHandler { call, result ->
            if (call.method == "installApk") {
                val path = call.argument<String>("path")
                if (path == null || path.isBlank()) {
                    result.error("INVALID_ARGS", "path is required", null)
                    return@setMethodCallHandler
                }
                try {
                    installApk(path)
                    result.success(true)
                } catch (e: Exception) {
                    Log.e(TAG, "installApk failed", e)
                    result.error("INSTALL_FAILED", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun installApk(path: String) {
        val file = File(path)
        if (!file.exists()) {
            throw IllegalArgumentException("APK file not found: $path")
        }
        val uri: Uri = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            FileProvider.getUriForFile(
                this,
                "${applicationContext.packageName}.fileProvider",
                file,
            )
        } else {
            Uri.fromFile(file)
        }
        val intent = Intent(Intent.ACTION_VIEW).apply {
            setDataAndType(uri, "application/vnd.android.package-archive")
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        startActivity(intent)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.i(TAG, "onActivityResult requestCode: $requestCode")
        mEvent?.success("N/A")
    }
}
