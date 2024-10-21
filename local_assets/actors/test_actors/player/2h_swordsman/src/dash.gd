extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var attack1_state: PlayerState

func enter() -> void:
    parent.animations.play(animation_name + "_" + parent.last_heading)
    parent.can_attack = false
    pass

func process_input(_event: InputEvent) -> PlayerState:
    if Input.is_action_just_pressed("p1_attack_primary") and parent.can_attack:
        return attack1_state
    return null

func process_physics(delta: float) -> PlayerState:
    parent.update_velocity(delta)
    parent.move_and_slide()
    if not parent.animations.is_playing():
        return idle_state
    return null
