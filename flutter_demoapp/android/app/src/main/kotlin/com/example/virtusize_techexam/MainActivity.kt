package com.example.virtusize_techexam

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.ivanbautista.virtusizesdk.VirtusizeSDK

class MainActivity: FlutterActivity() {
    private val CHANNEL = "virtusize_sdk"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getRecommendedSize" -> {
                    val height = call.argument<Double>("heightCm") ?: 0.0
                    val weight = call.argument<Double>("weightKg") ?: 0.0

                    try {
                        val size = VirtusizeSDK.getRecommendedSize(height, weight)
                        result.success(size)
                    } catch (e: Exception) {
                        result.error("SDK_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
