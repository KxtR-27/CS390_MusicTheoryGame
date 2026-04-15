extends Control

# amount of notes players need to guess (1? for now)
# accuracy variable same as used in attack script - get from there

#var noteGuessAmount = 1
#var rightNote: bool = false 
var enemyAttackPoints := 10
var healthStandIn := 100

signal close_defense

@onready var player_hp: Label = $CanvasLayer/playerHP


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_defense"):
		emit_signal("close_defense")

#note range of collision has to take in not hit or hit value from master cursor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var damagePercentage: float = randf() * enemyAttackPoints
	print("Damage to subtract: ", damagePercentage)
	var newHealth: int = healthStandIn - round(damagePercentage)
	player_hp.text = str(newHealth) + "/100"
