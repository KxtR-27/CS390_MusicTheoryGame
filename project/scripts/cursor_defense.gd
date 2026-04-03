class_name Cursor2 extends Area2D

#sustaining notes?
#how to now play the last note as a player

@export var note: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	# check type
	note = body as CharacterBody2D
	# put into groups instead of checking body names
	if (body.name == "cNote"): 
		$cNoteExSound.play()
	if (body.name == "cNote2"):
		$cNoteExSound.play()
	if (body.name == "eNote"):
		$eNoteExSound.play()
	#if (body.name == "eNote2"):
		#$eNoteExSound.play()
		#print("Yes! E!")
	#if (body.name == "notENote"):
		#print("You did not hit the correct note.")

		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Defense time! Listen to the first note played, then the second (hidden) note, and position where the second note is by the third measure.")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
