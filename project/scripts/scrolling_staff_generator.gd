class_name ScrollingStaffGenerator extends Node2D

@export var scroll_speed : int = 250
@export var beats_elapsed : int = 0
@export var measure : int = 0
@export var tempo : int = 0
@export var current_instrument : String = "Sine"
@export var song : Song

@export var current_track : Array = []

@export var spawner : ScrollingNoteSpawner

@export var amy_manager : AmyManager


func _create_song(new_song : Song) -> void:
	print("creating song")
	for measure_index : int in new_song.measures.keys():
		var loaded_measure : Measure = new_song.measures[measure_index]
		for note_index : int in loaded_measure.notes.keys():
			var current_note : SequencerNote = loaded_measure.notes[note_index]
			if current_note.instrument == current_instrument:
				current_track.push_back(current_note)


func _spawn_measure(measure_num : int) -> void:
	print("spawning measure ", measure_num)
	var notes_to_spawn : Array = []
	
	if not current_track.is_empty():
			var mismatch : bool = false
			while mismatch == false and not current_track.is_empty():
				var next_note : SequencerNote = current_track[0]
				if current_track[0].measure == measure_num:
					notes_to_spawn.append(next_note)
					current_track.pop_front()
				else:
					mismatch = true
	else:
		var measure_timer : Timer = $MeasureTimer
		measure_timer.stop()
	
	if not notes_to_spawn.is_empty():
		for note : SequencerNote in notes_to_spawn:
			spawner.spawn_note(note, scroll_speed)


func _play_song() -> void:
	measure = 0
	_spawn_measure(0)
	measure += 1
	print("playing song")
	
	var measure_timer : Timer = $MeasureTimer
	measure_timer.start()


func _load_song(new_song : Song) -> void:
	song = new_song
	current_track.clear()
	tempo = new_song.tempo
	print("loading song")
	_create_song(new_song)


func _on_load_button_button_down() -> void:
	var file_dialog : FileDialog = $FileDialog
	file_dialog.popup_centered()


func _on_file_dialog_file_selected(path: String) -> void:
	var path_string_split = path.split("/")
	var file_name = path_string_split[(path_string_split.size() - 1)]
	var label : Label = $MainControl/LoadSongHBox/CurrentSongLabel
	label.text = "Current song: " + file_name
	var loaded_song : Song = ResourceLoader.load(path, "Song")
	_load_song(loaded_song)
	print("file selected")


func _on_measure_timer_timeout() -> void:
	_spawn_measure(measure)
	measure += 1
	print("timeout")


func _on_play_button_button_down() -> void:
	_play_song()


func _on_clear_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ScrollingNotes"):
		area.queue_free()
