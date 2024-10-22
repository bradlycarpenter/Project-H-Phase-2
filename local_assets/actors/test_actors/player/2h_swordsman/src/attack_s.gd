extends PlayerState

@export var idle_state: PlayerState
var last_direction: Vector2

func enter() -> void:
	parent.animations.play(animation_name + "_" + parent.last_heading)
	parent.can_attack = false
	last_direction = parent.get_input_direction()
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