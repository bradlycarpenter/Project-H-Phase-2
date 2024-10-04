extends CharacterBody2D

@export var speed = 300

@onready var animation_tree : AnimationTree = $AnimationTree

var input_direction : Vector2 = Vector2.ZERO
var iso_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true

func _process(_delta):
	update_animation_parameters()

func _physics_process(delta):
	update_direction(delta)
	move_and_slide()

func update_direction(delta):
	input_direction = Input.get_vector(
	"move_left", 
	"move_right", 
	"move_up", 
	"move_down"
	).normalized()
	iso_direction = input_direction # have to seperate em for the state machine
	iso_direction.y /= 2 # for isometric correctnessness
	velocity = iso_direction * speed * delta * 100

func update_animation_parameters():
	if (input_direction == Vector2.ZERO):
		animation_tree["parameters/conditions/is_idling"] = true
		animation_tree["parameters/conditions/is_running"] = false

	else:
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_running"] = true
	
	if (input_direction != Vector2.ZERO): # so it stays facing last moved direction
		animation_tree["parameters/IDLE/blend_position"] = input_direction
		animation_tree["parameters/RUN/blend_position"] = input_direction
