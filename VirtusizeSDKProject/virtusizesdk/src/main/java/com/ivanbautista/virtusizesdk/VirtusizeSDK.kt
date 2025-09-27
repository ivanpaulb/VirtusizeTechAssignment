package com.ivanbautista.virtusizesdk

/**
 * Virtusize SDK - A BMI-dependent algorithm for computing size suggestions.
 */
object VirtusizeSDK {

    /**
     * Calculates BMI (kg/m²) and returns a recommended clothing size.
     *
     * @param heightCm Height in centimeters
     * @param weightKg Weight in kilograms
     * @return String containing recommended size
     * @throws IllegalArgumentException if height or weight are invalid
     */
    fun getRecommendedSize(heightCm: Double, weightKg: Double): String {
        require(heightCm > 0) { "Height must be positive." }
        require(weightKg > 0) { "Weight must be positive." }

        val heightM = heightCm / 100.0
        val bmi = weightKg / (heightM * heightM)

        return when {
            bmi < 18.5 -> "S"
            bmi < 25.0 -> "M"
            bmi < 30.0 -> "L"
            else -> "XL"
        }
    }
}