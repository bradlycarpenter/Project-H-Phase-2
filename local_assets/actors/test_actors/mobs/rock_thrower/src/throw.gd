extends MobState

@export var idle_state: MobState 
@export var rock: PackedScene

func enter() -> void:
	parent.animations.play(animation_name + "_" + parent.last_heading)

func process_physics(_delta: float) -> MobState:
	if not parent.animations.is_playing():
		return idle_state
	return null

func shoot() -> void:
	var r = rock.instantiate()
	owner.add_child(r)
