package com.example.skietests

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform