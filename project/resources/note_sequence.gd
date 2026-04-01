@tool
class_name NoteSequence
extends Resource


@export var notes: Array[NoteEntry] = []


func _init() -> void:
	self.notes = [];


func get_notes() -> Array[NoteEntry]: 
	return notes
