extends Node2D

var defense_scene: PackedScene = preload("res://components/arpeggio_frame.tscn")
var defense_instance: Node


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_defense"):
		toggle_defense()


### NYI ###
func toggle_defense() -> void:
	if defense_instance == null:
		open_defense()
	else:
		close_defense()
func open_defense() -> void:
	defense_instance = defense_scene.instantiate()
	@warning_ignore("unsafe_property_access")
	@warning_ignore("unsafe_method_access")
	defense_instance.close_defense.connect(close_defense)
	self.add_child(defense_instance)
###########


func close_defense() -> void:
	if defense_instance:
		defense_instance.queue_free()
		defense_instance = null
   
func _ready() -> void:
	pass # Replace with function body.
