class_name Player
extends CharacterBody2D

@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@export var stats: Stats
@export var death_menu: Node
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shader_material: ShaderMaterial = animated_sprite_2d.material as ShaderMaterial
@onready var base_damage: int = stats.base_damage
@export var item_menu: Node
@export var item_menu_bg: Node

const y_vec_multiplier: float = 1.2
const x_vec_multiplier: float = 1.7

var iso_direction: Vector2
var last_heading: String = "S"
var can_attack: bool = true
var dashing : bool = false

var damage_applied: bool = false

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
	var reduced_damage:int = max(0, damage - stats.defense)
	stats.current_health -= reduced_damage
	damage_shader()
	if stats.current_health == 0:
		stats.current_health = 100
		death_menu.visible = true
		get_tree().paused = true

func damage_shader() -> void:
	
	shader_material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.1).timeout
	shader_material.set_shader_parameter("flash_modifier", 0)

func adjust_stat(stat_name, value):
	match stat_name:
		"health":
			stats.base_health += value
			stats.current_health = stats.base_health
			print(stats.current_health)
		"damage":
			stats.base_damage += value
			print(stats.base_damage)
		"crit":
			stats.crit_chance += value
			print(stats.crit_chance)
		"defense":
			stats.defense += value
			print(stats.defense)
		"speed":
			stats.move_speed += value
			print(stats.move_speed)
		"attack_speed":
			stats.attack_speed += value
			# Adjust playback speed here somehow
			# maybe animation_tree.set("parameters/attack/blend_time", attack_speed) once all attack animations are in
		"cooldown_reduction":
			stats.cooldown_reduction += value
		"double_hit_chance":
			stats.double_hit_chance += value
		"dash_count":
			stats.dash_count += value
			if stats.dash_count > 2:
				stats.dash_count = 2
			print(stats.dash_count)
		"shield":
			stats.shield += value
		"dash_attack":
			stats.dash_attack = true
	hide_item_menu()

func show_item_menu() -> void:
	item_menu_bg.visible = true
	get_tree().paused = true   # Pause the game
	await get_tree().create_timer(0.4).timeout
	item_menu.change_items()
	item_menu.visible = true  # Show the item menu


func hide_item_menu() -> void:
	item_menu_bg.visible = false
	item_menu.visible = false  # Hide the item menu
	get_tree().paused = false   # Unpause the game
