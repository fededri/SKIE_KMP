package com.example.kmmapp.reactive

import co.touchlab.skie.configuration.annotations.DefaultArgumentInterop
import co.touchlab.skie.configuration.annotations.FlowInterop
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.onCompletion
import kotlinx.coroutines.flow.onStart
import kotlin.time.Duration
import kotlin.time.Duration.Companion.seconds

object TickProvider {
    @DefaultArgumentInterop.Enabled
    fun ticks(period: Duration = 1.seconds): Flow<Unit> = flow {
        while (true) {
            emit(Unit)
            delay(period)
        }
    }
        .onStart { println("onStart") }
        .onCompletion { println("onCompletion $it") }

    @FlowInterop.Disabled
    fun ticksWithoutSKIE(period: Duration = 1.seconds): Flow<Unit> = flow {
        while (true) {
            emit(Unit)
            delay(period)
        }
    }
}