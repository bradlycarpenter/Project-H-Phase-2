extends PlayerState

@export var idle_state: PlayerState
@export var attack1_state : PlayerState

func enter() -> void:
    pass

func exit() -> void:
    pass

func process_input(_event: InputEvent) -> PlayerState:
    if Input.is_action_just_pressed("p1_attack_primary"):
        return attack1_state
    return null

func process_frame(delta: float) -> PlayerState:
    parent.update_velocity(delta)
    parent.move_and_slide()
    if parent.velocity == Vector2.ZERO:
        return idle_state
    parent.animations.play(animation_name + "_" + parent.get_heading())
    return null

func process_physics(_delta: float) -> PlayerState:
    return null