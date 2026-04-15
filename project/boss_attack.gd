extends State
class_name BossAttack

@export var enemy: Enemy
@export var batNavMenu: BattleNavMenu

func Enter() -> void:
	batNavMenu.can_interact = false
	
	print("Boss turn!")
	enemy.attack_player()
	await get_tree().create_timer(0.5).timeout
	Transitioned.emit(self, "playerattack")


func Exit() -> void:
	pass


func Update(_delta: float) -> void:
	pass


func Physics_Update(_delta: float) -> void:
	pass
