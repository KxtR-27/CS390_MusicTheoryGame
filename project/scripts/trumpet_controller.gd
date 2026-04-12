@tool
class_name TrumpetController
extends Node


# 
static var Notes := Note.Notes

static var EMBOUCHURE_INPUT_MAP: Dictionary[String, int] = {
	"trumpet_open_bottom": 0,
	"trumpet_open_left": 1,
	"trumpet_open_right": 2, 
	"trumpet_open_top": 3,
}

## keys are boolean parsed arrays of valve combos
## values are embouchure arrays
## this is line-for-line in project root trumpet fingerings
static var NOTE_MAP: Dictionary[Array, Array] = {
	[false, false, false]: [Note.new(Notes.C, 4),       Note.new(Notes.G, 4),       Note.new(Notes.C, 5),        Note.new(Notes.E, 5)],
	[false, true,  false]: [Note.new(Notes.B, 3),       Note.new(Notes.F_SHARP, 4), Note.new(Notes.B, 4),        Note.new(Notes.D_SHARP, 5)],
	[true,  false, false]: [Note.new(Notes.B_FLAT, 3),  Note.new(Notes.F, 4),       Note.new(Notes.B_FLAT, 4),   Note.new(Notes.D, 5)],
	[true,  true,  false]: [Note.new(Notes.A, 3),       Note.new(Notes.E, 4),       Note.new(Notes.A, 4),        Note.new(Notes.C_SHARP, 5)],
	[false, true,  true]:  [Note.new(Notes.G_SHARP, 3), Note.new(Notes.D_SHARP, 4), Note.new(Notes.G_SHARP, 4)],
	[true,  false, true]:  [Note.new(Notes.G, 3),       Note.new(Notes.D, 4)],
	[true,  true,  true]:  [Note.new(Notes.F_SHARP, 3), Note.new(Notes.C, 4)],
	
	# apparently you almost never close the third valve alone. 
	# like, it's weird. I cannot find a fingering chart that has an embouchure for just the third valve.
	# even my twin sister says you almost never hold only the third valve.
	# BUT. since it's technically an input option, the below is to appease the code throwing Nil
	# have fun with the exact same embouchure as open lol
	[false, false, true]:  [Note.new(Notes.C, 4),       Note.new(Notes.G, 4),       Note.new(Notes.C, 5),        Note.new(Notes.E, 5)],
}

@export_group("Instrumentation")
@export var embouchure: int
@export var valve_combo := [false, false, false]
@export var playing: bool = false

@export_group("Debug")
@export var current_note: Note
@export_tool_button("Update Note", "AudioStreamPolyphonic") var upd_n_btn := \
	func() -> void: _update_current_note()
@export_tool_button("Print Valve Flags", "ActionPaste") var flag_btn := \
	func() -> void: print(valve_combo)

var embouchure_input: String
#var current_note: Note = Note.new()

@onready var note_player: NotePlayer = $NotePlayer


func _ready() -> void:
	_update_current_note()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	var changed_embouchure: bool = _update_embouchure()
	var changed_valve_combo: bool = _update_valve_combo()
	
	if changed_embouchure or changed_valve_combo:
		_update_current_note()
	
	if (
		(embouchure_input != "" and Input.is_action_just_pressed(embouchure_input))
		or (playing and (changed_embouchure or changed_valve_combo))
	):
		note_player.play_note(current_note.transpose(-2), NoteSequence.Waves.PULSE, true)
		playing = true
	
	if embouchure_input and Input.is_action_just_released(embouchure_input):
		note_player.stop_note()
		embouchure_input = ""
		playing = false


func _update_embouchure() -> bool:
	for input: String in EMBOUCHURE_INPUT_MAP.keys():
		if Input.is_action_just_pressed(input):
			embouchure_input = input
			embouchure = EMBOUCHURE_INPUT_MAP.get(input)
			return true
	
	return false


func _update_valve_combo() -> bool:
	var changed := false
	
	const inputs_array: Array[String] = \
		["trumpet_valve_one", "trumpet_valve_two", "trumpet_valve_three"]
	
	for i in range(0, valve_combo.size()):
		if Input.is_action_pressed(inputs_array[i]) != valve_combo[i]:
			valve_combo[i] = !valve_combo[i]
			changed = true
	
	return changed


func _update_current_note() -> void:
	var new_note: Note = NOTE_MAP.get(valve_combo)[embouchure]
	if new_note:
		current_note = new_note
