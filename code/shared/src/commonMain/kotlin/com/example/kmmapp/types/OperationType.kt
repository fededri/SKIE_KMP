package com.example.kmmapp.types

import co.touchlab.skie.configuration.annotations.DefaultArgumentInterop

sealed class OperationType {
    data class Unknown(val message: String) : OperationType()
    data object Plus : OperationType()
    data object Minus : OperationType()
    data object Divide : OperationType()
    data object Multiply : OperationType()
    data object Clear : OperationType()
    data object Delete : OperationType()
    data object Equals : OperationType()
}

@DefaultArgumentInterop.Enabled
fun lookupOperationType(
    value: String,
    defaultValue: OperationType = OperationType.Unknown("Oops")
) = when (value) {
    "+" -> OperationType.Plus
    "-" -> OperationType.Minus
    "/" -> OperationType.Divide
    "*" -> OperationType.Multiply
    "C" -> OperationType.Clear
    "<" -> OperationType.Delete
    "=" -> OperationType.Equals
    else -> defaultValue
}