class_name MasterCursorArpeggio
extends Area2D

## the maximum distance the cursor can move from its origin. 
## this is a joystick with full tilt.
@export var max_offset: float = 20 # px

## remap the tilt range if this goes up so that it starts moving only when tilted that far
@export var deadzone: float = 0.0

@export var note: CharacterBody2D

var origin: Vector2
var offset: float
var tilt: float



func _ready() -> void:
	origin = self.position


func _process(_delta: float) -> void:
	tilt = Input.get_axis("Left Instrument Up", "Left Instrument Down")
	offset = max_offset * tilt
	self.position.y = origin.y + offset

	#if Input.is_action_just_pressed("Hit Note"): look for hit signal
		if note:
			print("note %s is hit!" % note.name)
		if (note.name == "eNote2"):
			$eNoteExSound.play()
			print("Yes! E!")
		if (note.name == "notENote"):
			$gNoteExSound.play()
			print("You did not hit the correct note.")
	else:
		print("no note was hit!")
	if note and note.name:
		return
	pass


func _on_body_entered(body: Node2D) -> void:
	# check type
	if (body is CharacterBody2D):
		#print(CharacterBody2D.name)
		#print(body.name)
		# play sound
		# will automatically cast body to type CharacterBody2D
		# still shows a warning though?
		
		# ignores the warning the one time
		@warning_ignore("unsafe_property_access")
		#print(body.velocity)
		
		# ignore all warnings of type between these annotations
		@warning_ignore_start("unsafe_property_access")
		#print(body.velocity)
		#print(body.velocity)
		@warning_ignore_restore("unsafe_property_access")
		pass
	
	# cast immediately, may cause errors if body is something like a RigidBody2D
	note = body as CharacterBody2D
	#if (body.name === "cNote"):
		#
	print("New note: %s" % body.name)
	pass


func _on_body_exited(_body: Node2D) -> void:
	note = null
	#print("%s is removed" % body.name)
