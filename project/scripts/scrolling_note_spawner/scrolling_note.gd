class_name ScrollingNote extends Area2D

@export var speed : int = 0
@export var hit : bool = false

func _physics_process(delta: float) -> void:
	position.x -= speed * delta


func _ready() -> void:
	add_to_group("ScrollingNotes")
