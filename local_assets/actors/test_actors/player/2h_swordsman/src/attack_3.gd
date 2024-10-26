extends PlayerState

@export var idle_state: PlayerState

func enter() -> void:
	parent.animations.play(animation_name + "_" + parent.last_heading)
	parent.base_damage = 30
	parent.can_attack = false
	parent.damage_applied = false

func process_physics(_delta: float) -> PlayerState:
	if not parent.animations.is_playing():
		return idle_state
	return null

func crit_hit(crit_chance: float) -> bool:
	var is_crit: bool = randf() < crit_chance
	var damage: float = parent.base_damage
	if is_crit:
		damage *= 2
		print("Crit hit")
		return true
	return false

func _on_hitbox_body_entered(body: Mob) -> void:
	if not parent.damage_applied and body.is_in_group("mob"):
		body.apply_damage(parent.base_damage)
		parent.damage_applied = true
