package com.age.fans

import io.flutter.app.FlutterApplication
import androidx.multidex.MultiDex

class AgeApp : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        MultiDex.install(this)
    }
}