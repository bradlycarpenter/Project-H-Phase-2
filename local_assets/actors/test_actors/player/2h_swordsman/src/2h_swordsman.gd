extends CharacterBody2D

const speed := 200
const y_vec_multiplier := 1.1
const x_vec_multiplier := 1.7
const diagonal_velocity := 0.353553

enum states {IDLE, RUN, DODGE, L_ATTACK, H_ATTACK, S_ATTACK}
var state = states.IDLE
var input_direction := Vector2.ZERO
var iso_direction := Vector2.ZERO
var anim_current_frame
var anim_current_progress
var last_heading : String = "S"


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	update_direction(delta)
	update_state()
	state_machine()
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

func update_state():
	if velocity == Vector2.ZERO:
		state = states.IDLE
	else:
		state = states.RUN

func heading(input_vector) -> String:
	
	if input_vector.length() == 0:
		return last_heading 

	var directions = ["E", "NE", "N", "NW", "W", "SW", "S", "SE"]
	var angle : int = rad_to_deg(input_vector.angle())  
	angle = (angle * -1) % 360  

	var index = int(round(angle / 45)) % 8  

	last_heading = directions[index]

	return last_heading


func state_machine():
	match state:
		states.IDLE:
			anim.play("idle_" + heading(get_input_direction()))

		states.RUN:
			anim_current_frame = anim.get_frame()
			anim_current_progress = anim.get_frame_progress()

			anim.play("run_"+ heading(get_input_direction()))

			anim.set_frame_and_progress(
				anim_current_frame,
				anim_current_progress
				)
		
		states.L_ATTACK:
			pass