class_name FeedbackNote extends Sprite2D

func play() -> void:
	var pos_offset : Vector2 = Vector2(0,-20)
	var target_position : Vector2 = global_position + pos_offset
	
	var tween : Tween = get_tree().create_tween()
	
	tween.tween_property(self, "global_position", target_position, 0.5)
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.5)
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
