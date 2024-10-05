extends CharacterBody2D

@onready var animation_tree := $AnimationTree

const speed := 300
const y_velocity := 0.6
const x_velocity := 0.9
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
	iso_direction = Vector2.ZERO

	if (get_input_direction() != Vector2.ZERO):
		if (Input.is_action_pressed("move_up")):
			if (Input.is_action_pressed("move_right")):
				iso_direction.y += -diagonal_velocity
				iso_direction.x += diagonal_velocity*2
			elif (Input.is_action_pressed("move_left")):
				iso_direction.y += -diagonal_velocity
				iso_direction.x += -diagonal_velocity*2
			else:
				iso_direction.y += -y_velocity

		elif (Input.is_action_pressed("move_down")):
			if (Input.is_action_pressed("move_right")):
				iso_direction.y += diagonal_velocity
				iso_direction.x += diagonal_velocity*2
			elif (Input.is_action_pressed("move_left")):
				iso_direction.y += diagonal_velocity
				iso_direction.x += -diagonal_velocity*2
			else:
				iso_direction.y += y_velocity

		elif (Input.is_action_pressed("move_right")):
			iso_direction.x += x_velocity

		elif (Input.is_action_pressed("move_left")):
			iso_direction.x += -x_velocity

	velocity = iso_direction * speed * delta * 100

func get_input_direction():
	input_direction = Input.get_vector(
	"move_left", 
	"move_right", 
	"move_up", 
	"move_down"
	).normalized()
	return input_direction

func update_animation_parameters():
	if (get_input_direction() == Vector2.ZERO):
		animation_tree["parameters/conditions/is_idling"] = true
		animation_tree["parameters/conditions/is_running"] = false

	else:
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_running"] = true
	
	if (get_input_direction() != Vector2.ZERO): # so it stays facing last moved direction
		animation_tree["parameters/IDLE/blend_position"] = input_direction
		animation_tree["parameters/RUN/blend_position"] = input_direction
