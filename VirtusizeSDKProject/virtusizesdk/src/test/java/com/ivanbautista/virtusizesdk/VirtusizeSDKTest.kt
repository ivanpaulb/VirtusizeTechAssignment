package com.ivanbautista.virtusizesdk

import org.junit.Assert.assertEquals
import org.junit.Test

class VirtusizeSDKTest {

    @Test
    fun testUnderweightReturnsS() {
        val size = VirtusizeSDK.getRecommendedSize(180.0, 55.0)
        assertEquals("S", size)
    }

    @Test
    fun testNormalWeightReturnsM() {
        val size = VirtusizeSDK.getRecommendedSize(170.0, 65.0)
        assertEquals("M", size)
    }

    @Test
    fun testOverweightReturnsL() {
        val size = VirtusizeSDK.getRecommendedSize(165.0, 75.0)
        assertEquals("L", size)
    }

    @Test
    fun testObeseReturnsXL() {
        val size = VirtusizeSDK.getRecommendedSize(160.0, 90.0)
        assertEquals("XL", size)
    }

    @Test(expected = IllegalArgumentException::class)
    fun testInvalidInputsThrowsException() {
        VirtusizeSDK.getRecommendedSize(0.0, -50.0)
    }
}
