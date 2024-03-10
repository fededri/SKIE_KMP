package com.example.kmmapp.reactive

import co.touchlab.skie.configuration.annotations.SuspendInterop
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlin.time.Duration.Companion.seconds

class ChatRoom {
    private val _messages = MutableStateFlow(emptyList<String>())
    val messages: StateFlow<List<String>> = _messages

    @Suppress("MemberVisibilityCanBePrivate")
    @Throws(RuntimeException::class)
    suspend fun send(message: String) {
        throw RuntimeException("This is a test")
        delay(1.seconds)

        _messages.value += message
    }

    @SuspendInterop.Disabled
    suspend fun sendWithoutSKIE(message: String) {
        send(message)
    }
}