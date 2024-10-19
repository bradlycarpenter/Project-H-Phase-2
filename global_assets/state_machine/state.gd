class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 200

const y_vec_multiplier: float = 1.2
const x_vec_multiplier: float = 1.7

var parent: Player
var iso_direction: Vector2
static var last_heading: String = "S"

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Input.get_vector(
	"p1_move_left",
	"p1_move_right",
	"p1_move_up",
	"p1_move_down"
	).normalized()
	return input_direction

func update_velocity(delta: float) -> void:
	var input_vector: Vector2 = get_input_direction()
	iso_direction.x = input_vector.x * 2
	iso_direction.y = input_vector.y
	if iso_direction.x == 0:
		iso_direction.y = input_vector.y * y_vec_multiplier
	if iso_direction.y == 0:
		iso_direction.x = input_vector.x * x_vec_multiplier
	parent.velocity = iso_direction * move_speed * delta * 100

func get_heading() -> String:
	if get_input_direction().length() == 0:
		return last_heading
	else:
		var directions := ["E", "NE", "N", "NW", "W", "SW", "S", "SE"]
		var angle: int = int(rad_to_deg(get_input_direction().angle()))
		angle = (angle * -1) % 360
		var index: int = (roundi(angle / 45)) % 8
		last_heading = directions[index]
		return last_heading
