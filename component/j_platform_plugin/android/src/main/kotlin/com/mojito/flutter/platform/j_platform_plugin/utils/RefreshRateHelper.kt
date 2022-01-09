package com.mojito.flutter.platform.j_platform_plugin.utils

import android.content.Context
import android.util.Log
import android.view.WindowManager
import com.mojito.flutter.platform.j_platform_plugin.JPlatformPlugin


object RefreshRateHelper {
    private const val DEFAULT_REFRESH_RATE = 60.0

    /**
     * 获取手机的屏幕刷新率
     * 默认返回 60.0
     */
    fun getRefreshRate(context: Context): Double {
        try {
            val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val refreshRate = windowManager.defaultDisplay.refreshRate.toDouble()
//            return windowManager.defaultDisplay.refreshRate.toDouble()
            Log.d(JPlatformPlugin.TAG, "getRefreshRate: refreshRate = $refreshRate")
            return refreshRate ?: DEFAULT_REFRESH_RATE
        } catch (e: Exception) {
            Log.e(JPlatformPlugin.TAG, "getRefreshRate: $e", e)
        }
        return DEFAULT_REFRESH_RATE
    }
}