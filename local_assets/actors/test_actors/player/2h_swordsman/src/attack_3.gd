extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState

func enter() -> void:
    parent.animations.play(animation_name + "_" + parent.last_heading)
    parent.can_attack = false
    pass

func process_physics(_delta: float) -> PlayerState:
    if not parent.animations.is_playing():
        return idle_state
    return null