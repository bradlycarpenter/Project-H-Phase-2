extends CharacterBody2D

@onready var animation_tree := $AnimationTree

const speed := 200
const y_vec_multiplier := 1.1
const x_vec_multiplier := 1.7
const diagonal_velocity := 0.353553

var input_direction := Vector2.ZERO
var iso_direction := Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	update_direction(delta)
	update_animation_parameters()
	move_and_slide() # okay we actually need for collisions FUCK

func update_direction(delta):
	var input_vector = get_input_direction()

	iso_direction.x = input_vector.x * 2
	iso_direction.y = input_vector.y

	if iso_direction.x == 0:
		iso_direction.y = input_vector.y * y_vec_multiplier

	if iso_direction.y == 0:
		iso_direction.x = input_vector.x * x_vec_multiplier

	velocity = iso_direction * speed * delta * 100

func get_input_direction():
	input_direction = Input.get_vector(
	"p1_move_left",
	"p1_move_right",
	"p1_move_up",
	"p1_move_down"
	).normalized()
	return input_direction


func update_animation_parameters():
	if (Input.is_action_just_pressed("p1_attack_primary")):
		animation_tree["parameters/conditions/is_attack1"] = true
	else:
		animation_tree["parameters/conditions/is_attack1"] = false

	if (get_input_direction() == Vector2.ZERO):
		animation_tree["parameters/conditions/is_running"] = false
		animation_tree["parameters/conditions/is_idling"] = true

	else:
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_running"] = true
	
	if (get_input_direction() != Vector2.ZERO): # so it stays facing last moved direction
		animation_tree["parameters/IDLE/blend_position"] = input_direction
		animation_tree["parameters/RUN/blend_position"] = input_direction
		animation_tree["parameters/ATTACK1/blend_position"] = input_direction
	
	if (Input.is_action_just_pressed("p1_attack_primary")):
		animation_tree["parameters/conditions/is_attack1"] = true
	else:
		animation_tree["parameters/conditions/is_attack1"] = false
