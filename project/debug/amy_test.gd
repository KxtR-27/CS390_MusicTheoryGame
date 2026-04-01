@tool
class_name AmyWrapper 
extends Node

# wraps a node from the plugin "AMY Music Synthesizer"
# AssetLib: https://godotengine.org/asset-library/asset/4952

signal note_played
signal note_stopped

enum Notes {
	C = 0,		
	C_SHARP = 1, D_FLAT = 1,	
	D = 2,		
	D_SHARP = 3, E_FLAT = 3,	
	E = 4,
	F = 5,	
	F_SHARP = 6,	G_FLAT = 6,	
	G = 7,		
	G_SHARP = 8,	A_FLAT = 8,	
	A = 9,		
	A_SHARP = 10,	B_FLAT = 10,
	B = 11,
}

const starting_frequency := 16.35 # C0

@export var notes_to_play: Array[NoteEntry] = [
	NoteEntry.new(),
	NoteEntry.new(Notes.E, 4),
	NoteEntry.new(Notes.G, 4)
]

@export_tool_button("Play Notes", "AudioStreamWAV") var play_notes_button := \
	func() -> void:
		for noteEntry: NoteEntry in notes_to_play:
			print(noteEntry)
			# thank Xander
			play_note(noteEntry)
			await get_tree().create_timer(noteEntry.sustain).timeout
			stop_note()
			await get_tree().create_timer(noteEntry.sustain).timeout

@onready var amy: Amy = _init_amy()
@onready var timer: Timer = $AmyTimer


func _init_amy() -> Amy:
	var newAmy := Amy.new()
	newAmy.name = "Amy"
	self.add_child(newAmy)
	return newAmy


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if Input.is_action_just_pressed("Hit Note"):
		play_note(NoteEntry.new(Notes.A, 4, 1))
	if Input.is_action_just_pressed("ui_up"):
		play_note(NoteEntry.new(Notes.A, 5, 1))
	if Input.is_action_just_pressed("ui_down"):
		play_note(NoteEntry.new(Notes.A, 3, 1))


func _on_amy_timer_timeout() -> void:
	stop_note()


func play_note(note: NoteEntry) -> void:
	if not amy: _init_amy()
	
	var note_freq: float = _calc_frequency(note.note, note.octave)
	print(note_freq)
	
	amy.send({"osc": 0, "wave": Amy.SINE, "freq": note_freq, "vel": 1})
	timer.start(note.sustain)
	note_played.emit()


func stop_note() -> void:
	amy.send({"osc": 0, "vel": 0})
	note_stopped.emit()


func _calc_frequency(note: int, octave: int) -> float:
	return (starting_frequency * pow(2, octave)) * pow(2, note/12.0)
