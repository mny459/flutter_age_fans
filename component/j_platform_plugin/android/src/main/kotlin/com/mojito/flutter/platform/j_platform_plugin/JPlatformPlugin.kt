package com.mojito.flutter.platform.j_platform_plugin

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.mojito.flutter.platform.j_platform_plugin.utils.RefreshRateHelper

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** JPlatformPlugin */
class JPlatformPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var mChannel: MethodChannel
    private lateinit var mAppContext: Context

    companion object {
        const val TAG = "JPlatformPlugin"
        private const val method_ = "method_demo"
        private const val METHOD_GET_REFRESH_RATE = "get_refresh_rate"
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        mChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "j_platform_plugin")
        mAppContext = flutterPluginBinding.applicationContext
        mChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        log("onMethodCall $call")
        when (call.method) {
            METHOD_GET_REFRESH_RATE -> {
                val refreshRate = RefreshRateHelper.getRefreshRate(mAppContext)
                log("onMethodCall $refreshRate")
                 result.success(refreshRate)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        mChannel.setMethodCallHandler(null)
    }

    private fun log(content: String) {
        Log.d(TAG, content)
    }
}
