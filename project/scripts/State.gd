@abstract
extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned

@abstract func Enter() -> void

@abstract func Exit() -> void

@abstract func Update(_delta: float) -> void

@abstract func Physics_Update(_delta: float) -> void
