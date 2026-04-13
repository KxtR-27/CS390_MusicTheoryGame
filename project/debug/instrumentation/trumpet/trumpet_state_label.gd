@tool
extends Label

@onready var parent: TrumpetStateDisplay = self.get_parent()
@onready var trumpet: TrumpetController = parent.trumpet

func _process(_delta: float) -> void:
	var trumpet_info := "Trumpet: %s" % trumpet.name if trumpet else "awaiting trumpet connection..."
	var note_info := "\nNote: %s" % trumpet.current_note.to_string() if trumpet else "\n"
	var embouchure_info := "\nEmbouchure: %s" % trumpet.embouchure_input if trumpet else "\n"
	var valve_combo_info := "\nValves: " + "".join([
		"○" if not trumpet.valve_combo[2] else "●",
		"○" if not trumpet.valve_combo[0] else "●",
		"○" if not trumpet.valve_combo[1] else "●",
	]) if trumpet else ""
	
	self.text = trumpet_info + note_info + embouchure_info + valve_combo_info
