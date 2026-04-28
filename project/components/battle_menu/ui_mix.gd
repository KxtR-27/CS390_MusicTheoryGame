class_name UiMix extends Node2D

@export var feedback_label : Label
@export var effect_label : Label
@export var critical_announcement_animator : AnimationPlayer
@export var boss_animator : AnimationPlayer
@export var floating_damage_label : Label

func _on_player_attack_boss_hurt(dmg : int) -> void:
	floating_damage_label.text = "-" + str(dmg)
	boss_animator.play("hurt_anim")
	await boss_animator.animation_finished
	boss_animator.play("idle")


func _on_player_attack_critical_performance() -> void:
	feedback_label.text = "100%! HARMONY!"
	effect_label.text = "100%! HARMONY!"
	critical_announcement_animator.play("critical")
	await critical_announcement_animator.animation_finished
	var player_attack_state : PlayerAttack = $StateMachine/PlayerAttack
	player_attack_state.resume_approved.emit()


func _on_boss_attack_critical_defense() -> void:
	feedback_label.text = "CRITICAL DEFENSE!"
	effect_label.text = "CRITICAL DEFENSE!"
	critical_announcement_animator.play("critical")
	await critical_announcement_animator.animation_finished
	var boss_attack_state : BossAttack = $StateMachine/BossAttack
	boss_attack_state.resume_approved.emit()


func _on_enemy_defeated() -> void:
	get_tree().change_scene_to_file("res://components/win_screen.tscn")


func _on_player_attack_players_lost() -> void:
	get_tree().change_scene_to_file("res://components/loss_screen.tscn")
