package com.example.kmmapp

class Greeting {
    private val platform: Platform = getPlatform()

    fun greet(): String {
        return "Hello Chamaco, ${platform.name}!"
    }
}