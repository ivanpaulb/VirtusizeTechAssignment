# Virtusize SDK

**Virtusize SDK** is a standalone Kotlin library that calculates BMI-based clothing size recommendations.  
It can be integrated into any Android or Kotlin project via an `.aar` file, and can also be used in Flutter projects via platform channels.

---

## Features

- Computes BMI from height and weight.
- Returns clothing size suggestions (`S`, `M`, `L`, `XL`) based on BMI.
- No external dependencies.
- Lightweight and easy to integrate using an `.aar` file.
- Compatible with Flutter via platform channels.

---

## Installation (Android / Kotlin)

### 1. Build the `.aar` file

1. Open the SDK project in Android Studio.
2. In the terminal, run:

./gradlew assembleRelease

3. The generated `.aar` file will be located in:

virtusizesdk/build/outputs/aar/virtusizesdk-release.aar

---

### 2. Include the `.aar` in your project

1. Copy the `.aar` file into your app module’s `libs` folder:

app/libs/virtusizesdk-release.aar

2. Add the following to your `build.gradle`:

repositories {
    flatDir {
        dirs 'libs'
    }
}

dependencies {
    implementation(name: 'virtusizesdk-release', ext: 'aar')
}

3. Sync Gradle. The SDK is now available in your project.

---

## Usage (Android / Kotlin)

### Import the SDK

import com.ivanbautista.virtusizesdk.VirtusizeSDK

### Get Recommended Size

val heightCm = 170.0
val weightKg = 65.0

try {
    val recommendedSize = VirtusizeSDK.getRecommendedSize(heightCm, weightKg)
    println("Recommended Size: $recommendedSize")
} catch (e: IllegalArgumentException) {
    println("Invalid input: ${e.message}")
}

**Output:**

Recommended Size: M

---

## API Reference

### VirtusizeSDK.getRecommendedSize(heightCm: Double, weightKg: Double): String

- **Parameters:**
  - heightCm — Height in centimeters (> 0)
  - weightKg — Weight in kilograms (> 0)
- **Returns:** Recommended clothing size: "S", "M", "L", or "XL"
- **Throws:** IllegalArgumentException if height or weight is invalid.

---

## Flutter Integration

This section explains how to use Virtusize SDK from a Flutter project via **platform channels**.

### 1. Add the `.aar` to Flutter Android Module

1. Copy `virtusizesdk-release.aar` to the Flutter project’s Android `libs` folder:

<flutter_project>/android/app/libs/virtusizesdk-release.aar

2. Add it as a dependency in `android/app/build.gradle`:

repositories {
    flatDir {
        dirs 'libs'
    }
}

dependencies {
    implementation(name: 'virtusizesdk-release', ext: 'aar')
}

3. Sync Gradle.

---

### 2. Dart Side (Flutter)

```dart
import 'package:flutter/services.dart';

class VirtusizeSDK {
  static const MethodChannel _channel =
      MethodChannel('virtusize_sdk_channel');

  static Future<String> getRecommendedSize(double heightCm, double weightKg) async {
    final String size = await _channel.invokeMethod('getRecommendedSize', {
      'heightCm': heightCm,
      'weightKg': weightKg,
    });
    return size;
  }
}
```

---

### 3. Android Side (Kotlin)

Add the platform channel in `MainActivity.kt`:

```kotlin
package com.example.yourapp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.ivanbautista.virtusizesdk.VirtusizeSDK

class MainActivity: FlutterActivity() {
    private val CHANNEL = "virtusize_sdk_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getRecommendedSize") {
                val height = call.argument<Double>("heightCm") ?: 0.0
                val weight = call.argument<Double>("weightKg") ?: 0.0

                try {
                    val size = VirtusizeSDK.getRecommendedSize(height, weight)
                    result.success(size)
                } catch (e: IllegalArgumentException) {
                    result.error("INVALID_INPUT", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
```

---

### 4. Using the SDK in Flutter

```dart
void main() async {
  double height = 170.0;
  double weight = 65.0;

  try {
    String size = await VirtusizeSDK.getRecommendedSize(height, weight);
    print('Recommended size: $size'); // Output: Recommended size: M
  } catch (e) {
    print('Error: $e');
  }
}
```

---

## Notes

- Ensure the method names in Dart and Kotlin match exactly (`getRecommendedSize`).
- Always handle errors, as invalid height or weight will throw an exception.
- The `.aar` SDK can be reused across multiple Flutter apps.

---

## License

MIT License
