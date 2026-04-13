@tool
class_name ViolinStateDisplay
extends Label

@export var violin: ViolinController

func _process(_delta: float) -> void:
	if !violin:
		text = "await violin connection..."
	else:
		var next_bow_dir: String = "Play a down bow!" if violin.last_bow_dir_was_up else "play an up bow!"
		var current_note: String = violin.current_note.to_string()
		text = "\n".join([next_bow_dir, current_note])
