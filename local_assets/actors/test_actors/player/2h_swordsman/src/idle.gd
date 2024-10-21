extends PlayerState

@export var run_state : PlayerState
@export var attack1_state : PlayerState

func enter() -> void:
    # super()
    parent.animations.play(animation_name + "_" + parent.last_heading)

func process_input(_event: InputEvent) -> PlayerState:
    if Input.is_action_just_pressed("p1_attack_primary"):
        return attack1_state
    return null

func process_frame(delta: float) -> PlayerState:
    parent.update_velocity(delta)
    if parent.velocity != Vector2.ZERO:
        return run_state

    return null