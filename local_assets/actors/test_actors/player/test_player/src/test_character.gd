extends CharacterBody2D

@onready var animation_tree := $AnimationTree
@export var stats: Resource

const y_vec_multiplier := 1.1
const x_vec_multiplier := 1.7

var input_direction := Vector2.ZERO
var iso_direction := Vector2.ZERO

# Player stats
var base_health: int = 100
var health: int = base_health
var base_damage: int = 50
var crit_chance: float = 0.1
var defense: float = 0.0
var speed: float = 200.0
var attack_speed: float = 1.0
var cooldown_reduction: float = 0.0
var lifesteal: float = 0.0
var double_hit_chance: float = 0.0
var dash_count: int = 1
var shield: int = 0
var dash_attack: bool = false

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	update_direction(delta)
	update_animation_parameters()
	move_and_slide() # okay we actually need for collisions FUCK

func update_direction(delta):
	iso_direction = Vector2.ZERO
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
	if (get_input_direction() == Vector2.ZERO):
		animation_tree["parameters/conditions/is_idling"] = true
		animation_tree["parameters/conditions/is_running"] = false

	else:
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_running"] = true

	if (get_input_direction() != Vector2.ZERO): # so it stays facing last moved direction
		animation_tree["parameters/IDLE/blend_position"] = input_direction
		animation_tree["parameters/RUN/blend_position"] = input_direction

func adjust_stat(stat_name, value):
	match stat_name:
		"health":
			base_health += value
			health = base_health
		"damage":
			base_damage += value
		"crit":
			crit_chance += value
		"defense":
			defense += value
		"speed":
			speed += value
		"attack_speed":
			attack_speed += value
			# Adjust playback speed here somehow
			# maybe animation_tree.set("parameters/attack/blend_time", attack_speed) once all attack animations are in
		"cooldown_reduction":
			cooldown_reduction += value
		"lifesteal":
			lifesteal += value
		"double_hit_chance":
			double_hit_chance += value
		"dash_count":
			dash_count += value
			if dash_count > 2:
				dash_count = 2
		"shield":
			shield += value
		"dash_attack":
			dash_attack = true

#func attack(target):
	# Attack template including crit hit
#	var is_crit: bool = randf() < crit_chance
#	var damage: float = base_damage
#	if is_crit:
#		damage *= 2
#		print("Crit hit")
#	target.take_damage(damage)

#func take_damage(damage):
#	var reduced_damage = max(0, damage - defense)
#	health -= reduced_damage
