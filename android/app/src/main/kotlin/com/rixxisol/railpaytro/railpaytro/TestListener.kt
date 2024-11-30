package com.tracsis.railpaytro.emr
interface TestListener {

    fun onComplete(transferRate: Double)

    fun onError(speedTestError: String, errorMessage: String)

    fun onProgress(percent: Double, transferRate: Double)

}

