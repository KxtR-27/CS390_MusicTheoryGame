class_name ScrollingNote extends Area2D

@export var speed : int = 0
@export var hit : bool = false
@export var pitch_name : String = "C"
@export var octave : int = 0

func _physics_process(delta: float) -> void:
	position.x -= speed * delta


func _ready() -> void:
	add_to_group("ScrollingNotes")
