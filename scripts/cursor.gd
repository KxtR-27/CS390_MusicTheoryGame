class_name Cursor extends Area2D


@export var note: CharacterBody2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Hit Note"):
		if note:
			print("note %s is hit!" % note.name)
		else:
			print("no note was hit!")
		pass


func _on_body_entered(body: Node2D) -> void:
	# check type
	if (body is CharacterBody2D):
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
	#print("New note: %s" % body.name)
	pass




func _on_body_exited(_body: Node2D) -> void:
	note = null
	#print("%s is removed" % body.name)
