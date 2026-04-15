extends Sprite2D
class_name Enemy

@export var health: float = 100
@onready var health_label = $EnemyHP/HPvalue

signal enemy_took_damage(current_health: int)

var players: Array[Player] = []

func _ready():
	randomize()
	enemy_took_damage.connect(_on_enemy_took_damage)
	update_health_label()



func _on_battle_menu_navigation_attack_enemy(damage: float) -> void: 
	health -= damage
	health = max(health, 0)
	enemy_took_damage.emit(health)


# Random damage generator
func deal_random_damage(min_damage: float, max_damage: float) -> float:
	return randf_range(min_damage, max_damage)



func attack_player():
	var target = get_random_player()
	if target == null:
		print("No valid targets")
		return
	
	var damage = int(deal_random_damage(1, 5))
	print("Boss attacks ", target.name, " for ", damage, " damage!")
	
	target.take_damage(damage)


# Picks a random ALIVE player
func get_random_player() -> Player:
	var alive_players: Array[Player] = []
	
	for p in players:
		if p.health > 0:
			alive_players.append(p)
	
	if alive_players.is_empty():
		return null
	
	return alive_players[randi_range(0, alive_players.size() - 1)]


# Updates UI
func _on_enemy_took_damage(current_health: int) -> void:
	update_health_label()


func update_health_label():
	health_label.text = "Health: " + str(int(health)) + "/100"
