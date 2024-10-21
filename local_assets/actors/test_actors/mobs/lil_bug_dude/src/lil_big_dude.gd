# lil bug dude
class_name Mob
extends CharacterBody2D

@onready var state_machine: MobStateMachine = $MobStateMachine
@onready var animations: AnimationPlayer = $AnimationPlayer

var last_heading: String = "S"

func _ready() -> void:
	animations.speed_scale = 0.8
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func get_heading() -> String:
	if velocity.length() == 0:
		return last_heading
	else:
		var directions := ["E", "NE", "N", "NW", "W", "SW", "S", "SE"]
		var angle: int = int(rad_to_deg(velocity.angle()))
		angle = (angle * -1) % 360
		@warning_ignore("integer_division")
		var index: int = (roundi(angle / 45)) % 8
		last_heading = directions[index]
		return last_heading
