extends State
class_name PlayerAttack

@export var batNavMenu: BattleNavMenu


func Enter() -> void:
	batNavMenu.can_interact = true

func Exit() -> void:
	pass

func Update(_delta: float) -> void:
	if batNavMenu.note_list.visible and Input.is_action_just_pressed("ui_cancel"):
		batNavMenu.reset_battle_menu()

	if batNavMenu.note_list.visible and Input.is_action_just_pressed("ui_accept"):
		print("the mana of move used is " + str(batNavMenu.currently_selected_move.mana_value))
		print("The mana the currently selected player has is" + str(batNavMenu.currently_selected_player.mana))
		if (batNavMenu.currently_selected_move.mana_value > batNavMenu.currently_selected_player.mana):
			return
		batNavMenu.currently_selected_player.mana -= batNavMenu.currently_selected_move.mana_value
		batNavMenu.mana_changed.emit(batNavMenu.currently_selected_player)
		batNavMenu.attack_enemy.emit(batNavMenu.currently_selected_move.DMG)
		if batNavMenu.currently_selected_player == batNavMenu.player1:
			batNavMenu.currently_selected_player = batNavMenu.player2
			batNavMenu.reset_battle_menu()


func Physics_Update(_delta: float) -> void:
	pass
