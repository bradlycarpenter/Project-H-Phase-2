class_name Player
extends CharacterBody2D

@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@export var stats: Stats
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shader_material: ShaderMaterial = animated_sprite_2d.material as ShaderMaterial

const y_vec_multiplier: float = 1.2
const x_vec_multiplier: float = 1.7

var iso_direction: Vector2
var last_heading: String = "S"
var can_attack: bool = true
var move_speed: float = 150
var dashing : bool = false
var current_attack_damage:int

var damage_applied: bool = false
var health: int = 100

func _ready() -> void:
	shader_material.set_shader_parameter("flash_modifier", 0)
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func set_can_attack_to_true() -> void:
	can_attack = true

func set_dashing_to_true() -> void:
	dashing = true

func set_dashing_to_false() -> void:
	dashing = false

func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Input.get_vector(
	"p1_move_left",
	"p1_move_right",
	"p1_move_up",
	"p1_move_down"
	).normalized()
	return input_direction

func update_velocity(delta: float, input_direction: Vector2) -> void:
	var input_vector: Vector2 = input_direction 
	iso_direction.x = input_vector.x * 2
	iso_direction.y = input_vector.y
	if iso_direction.x == 0:
		iso_direction.y = input_vector.y * y_vec_multiplier
	if iso_direction.y == 0:
		iso_direction.x = input_vector.x * x_vec_multiplier
	velocity = iso_direction * stats.move_speed * delta * 100

func get_heading() -> String:
	if get_input_direction().length() == 0:
		return last_heading
	else:
		var directions := ["E", "NE", "N", "NW", "W", "SW", "S", "SE"]
		var angle: int = int(rad_to_deg(get_input_direction().angle()))
		angle = (angle * -1) % 360
		@warning_ignore("integer_division")
		var index: int = (roundi(angle / 45)) % 8
		last_heading = directions[index]
		return last_heading

func adjust_speed(amount: float) -> void:
	stats.move_speed += amount
	#var save = ResourceSaver.save(stats)
	print(stats.move_speed)
	
func apply_damage(damage: int) -> void:
	health -= damage
	damage_shader()
	print(damage)
	if health <= 0:
		queue_free()

func damage_shader() -> void:
	
	shader_material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.1).timeout
	shader_material.set_shader_parameter("flash_modifier", 0)
