extends State

@export var run_state : State
@export var attack1_state : State

func enter() -> void:
	# super()
	parent.animations.play(animation_name + "_" + last_heading)

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("p1_attack_primary"):
		return attack1_state
	return null

func process_frame(delta: float) -> State:
	update_velocity(delta)
	if parent.velocity != Vector2.ZERO:
		return run_state

	return null