extends Node2D


@onready var player: NotePlayer = $NotePlayer


func _ready() -> void:
	# load sequence manually
	#var loaded_sequence: NoteSequence = load("res://resources/sequences/c_major_arpeggio.tres")
	#player.play_sequence(loaded_sequence)
	
	# use the player's sequence from the editor
	player.play_sequence(player.note_sequence)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		player.play_next_note_in_await.emit(NotePlayer.PlayAwaitTypes.HIT)
	if Input.is_action_just_pressed("ui_right"):
		player.play_next_note_in_await.emit(NotePlayer.PlayAwaitTypes.SKIP)
	if Input.is_action_just_pressed("ui_down"):
		player.play_next_note_in_await.emit(NotePlayer.PlayAwaitTypes.EXTRA)
