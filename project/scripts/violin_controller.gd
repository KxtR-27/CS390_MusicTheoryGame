@tool
class_name ViolinController
extends Node


static var note_inputs_map: Dictionary[String, Note] = {
		"violin_open_g": Note.new(Note.Notes.G, 3, 0.5), 
		"violin_open_d": Note.new(Note.Notes.D, 4, 0.5), 
		"violin_open_a": Note.new(Note.Notes.A, 4, 0.5), 
		"violin_open_e": Note.new(Note.Notes.E, 5, 0.5),
}

# start with down-bow
@export var last_bow_dir_was_up := true
@export var current_note: Note = note_inputs_map.get("violin_open_d")
@export var accepting_input := true

@onready var note_player: NotePlayer = $NotePlayer


func _process(_delta: float) -> void:
	if Engine.is_editor_hint() or not accepting_input:
		return
	
	_update_current_note()
	
	var hit_occurred: bool = _check_for_hit()
	if hit_occurred:
		print("note played!")
		last_bow_dir_was_up = not last_bow_dir_was_up
		note_player.play_note(current_note, NoteSequence.Waves.SAW_DOWN)


func _update_current_note() -> void:
	for input: String in note_inputs_map.keys():
		if Input.is_action_just_pressed(input):
			print("note changed!")
			current_note = note_inputs_map.get(input)


func _check_for_hit() -> bool:
	var hit_down: bool = (
		Input.is_action_just_pressed("violin_bow_down") 
		and last_bow_dir_was_up
	)
	var hit_up: bool = (
		not hit_down 
		and Input.is_action_just_pressed("violin_bow_up") 
		and not last_bow_dir_was_up
	)
	
	return hit_down or hit_up;
