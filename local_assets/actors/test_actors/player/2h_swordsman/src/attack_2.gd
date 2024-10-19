extends State

@export var idle_state: State
@export var run_state: State
@export var attack3_state: State

func enter() -> void:
	parent.animations.play(animation_name + "_" + last_heading)
	parent.can_attack = false
	pass

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("p1_attack_primary") and parent.can_attack:
		return attack3_state
	return null

func process_physics(_delta: float) -> State:
	if not parent.animations.is_playing():
		return idle_state
	return null