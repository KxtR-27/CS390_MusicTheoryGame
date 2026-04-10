class_name ScrollingNoteSpawner extends Node2D

const OCTAVE_OFFSET : int = 4
const SCROLLING_NOTE = preload("res://scenes/scrolling_notes_spawner/scrolling_note.tscn")

var offset_interval : float = 20.0
var default_offset : float = offset_interval * 7
var note_offsets : Dictionary = {
	"B" = 6,
	"A" = 5,
	"G" = 4,
	"F" = 3,
	"E" = 2,
	"D" = 1,
	"C" = 0
}


func spawn_note(note : SequencerNote, speed : int) -> void:
	var note_pitch : String = note.pitch_name
	var octave : int = note.octave - OCTAVE_OFFSET
	var new_scrolling_note : ScrollingNote = SCROLLING_NOTE.instantiate()
	
	add_child(new_scrolling_note)
	
	var offset : float = offset_interval * note_offsets[note_pitch]
	offset += (octave * offset_interval)
	offset += default_offset
	
	#new_scrolling_note.position = self.position
	new_scrolling_note.position.x += (note.beat - 1) * 0.25 * speed
	new_scrolling_note.position.y -= offset
	print(new_scrolling_note.position, " ", note_pitch, "beat ", note.beat)
	new_scrolling_note.speed = speed
