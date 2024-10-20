extends MobState

func enter() -> void:
    # super()
    parent.animations.play(animation_name + "_" + parent.last_heading)