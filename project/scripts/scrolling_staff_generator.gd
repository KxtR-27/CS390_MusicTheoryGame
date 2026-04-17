class_name ScrollingStaffGenerator
extends Node2D

@export var debug : bool = false
@onready var staff_minigame : StaffMinigame = $StaffMinigame
@onready var main_control : Control = $MainControl

signal song_finished(accuracy : float)

func _ready() -> void:
	if debug:
		$MainControl/LoadSongHBox.visible = true
		$MainControl/ScoreLabel.visible = true
		$MainControl/PlayButton.visible = true

func play_song(song : Song) -> void:
	staff_minigame.reset()
	staff_minigame._load_song(song)
	staff_minigame._play_song()
	
	main_control.visible = true


func _on_load_button_button_down() -> void:
	var file_dialog : FileDialog = $FileDialog
	file_dialog.popup_centered()


func _on_file_dialog_file_selected(path: String) -> void:
	var path_string_split : Array = path.split("/")
	var file_name : String = path_string_split[(path_string_split.size() - 1)]
	var label : Label = $MainControl/LoadSongHBox/CurrentSongLabel
	label.text = "Current song: " + file_name
	var loaded_song : Song = ResourceLoader.load(path, "Song")
	staff_minigame._load_song(loaded_song)


func _on_play_button_button_down() -> void:
	staff_minigame._play_song()


func _on_staff_minigame_score_tallied(hit_percentage: float) -> void:
	song_finished.emit(hit_percentage)
	main_control.visible = false
