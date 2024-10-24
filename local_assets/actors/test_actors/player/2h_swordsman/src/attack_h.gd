extends PlayerState

@export var idle_state: PlayerState

func enter() -> void:
	parent.animations.play(animation_name + "_" + parent.last_heading)
	parent.can_attack = false
	pass

func process_input(_event: InputEvent) -> PlayerState:
	return null

func process_physics(_delta: float) -> PlayerState:
	if not parent.animations.is_playing():
		return idle_state
	return null


func _on_hitbox_body_entered(body: Mob) -> void:
	if not parent.damage_applied and body.is_in_group("mob"):
		body.apply_damage(parent.current_attack_damage)
		parent.damage_applied = true
