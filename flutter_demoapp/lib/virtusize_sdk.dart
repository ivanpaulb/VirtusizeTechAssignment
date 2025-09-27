import 'package:flutter/services.dart';

class VirtusizeSDK {
  static const MethodChannel _channel = MethodChannel('virtusize_sdk');

  static Future<String> getRecommendedSize({
    required double heightCm,
    required double weightKg,
  }) async {
    final result = await _channel.invokeMethod<String>(
      'getRecommendedSize',
      {
        'heightCm': heightCm,
        'weightKg': weightKg,
      },
    );
    return result ?? "Unknown";
  }
}
