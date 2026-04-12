@tool
class_name TrumpetStateDisplay
extends Control


@export var trumpet: TrumpetController

@onready var label: Label = $InfoLabel


func _process(_delta: float) -> void:
	var trumpet_info := "Trumpet: %s" % trumpet.name if trumpet else "await trumpet connection..."
	var note_info := "\nNote: %s" % trumpet.current_note.to_string() if trumpet else ""
	var embouchure_info := "\nEmbouchure: %s" % trumpet.embouchure if trumpet else ""
	var valve_combo_info := "\nValves: " + ", ".join(trumpet.valve_combo) if trumpet else ""
	
	label.text = trumpet_info + note_info + embouchure_info + valve_combo_info
