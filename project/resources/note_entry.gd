class_name NoteEntry
extends Resource

@export var note: AmyWrapper.Notes # = AmyWrapper.Notes.C
@export var octave: int # = 4
@export var sustain: float # = 1.0

func _init(n: AmyWrapper.Notes = AmyWrapper.Notes.C, o: int = 4, s: float = 1.0) -> void:
	self.note = n
	self.octave = o
	self.sustain = s
