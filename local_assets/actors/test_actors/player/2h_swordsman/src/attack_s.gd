extends PlayerState

@export var idle_state: PlayerState
var last_direction: Vector2

func enter() -> void:
	#if parent.stats.dash_attack:
		parent.base_damage = 30
		parent.animations.play(animation_name + "_" + parent.last_heading)
		parent.can_attack = false
		last_direction = parent.get_input_direction()
		parent.damage_applied = false
		pass

func process_input(_event: InputEvent) -> PlayerState:
	return null

func process_physics(delta: float) -> PlayerState:
	if parent.dashing == true:
		parent.update_velocity(delta, last_direction)
		parent.velocity *= 3
		parent.move_and_slide()
	if not parent.animations.is_playing():
		return idle_state
	return null


func _on_hitbox_body_entered(body: Node2D) -> void:
	if not parent.damage_applied and body.is_in_group("mob"):
		parent.stats.damage = parent.base_damage + parent.stats.base_damage
		body.apply_damage(parent.stats.damage)
		parent.damage_applied = true 
