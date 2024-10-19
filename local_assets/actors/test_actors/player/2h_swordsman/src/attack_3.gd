extends State

@export var idle_state: State
@export var run_state: State

func enter() -> void:
	parent.animations.play(animation_name + "_" + last_heading)
	parent.can_attack = false
	pass

func process_physics(_delta: float) -> State:
	if not parent.animations.is_playing():
		return idle_state
	return null