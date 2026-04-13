@tool
extends Label


@onready var parent: ViolinStateDisplay = self.get_parent()
@onready var violin: ViolinController = parent.violin


func _process(_delta: float) -> void:
	if !violin:
		self.text = "awaiting violin connection...\n\n\n"
	else:
		var next_bow_dir: String = "Play a down bow!" if violin.last_bow_dir_was_up else "Play an up bow!"
		var current_open_note: String = "Current string: %s" % violin.open_notes_map.find_key(violin.current_open_note)
		var current_note: String = violin.current_open_note.bend(violin.current_finger_position + violin.finger_position_modifier)._to_string()
		
		var current_finger_pos_string: String = ""
		match (violin.current_finger_position):
			0: current_finger_pos_string = "open"
			2: current_finger_pos_string = "1st"
			4: current_finger_pos_string = "2nd"
			5: current_finger_pos_string = "3rd"
			7: current_finger_pos_string = "4th"
		
		var parsed_finger_pos: String = "Finger position: %s" % current_finger_pos_string
		
		self.text = "\n".join([next_bow_dir, current_open_note, parsed_finger_pos, current_note])
