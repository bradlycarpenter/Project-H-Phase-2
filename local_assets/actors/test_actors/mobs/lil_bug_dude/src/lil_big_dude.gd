# lil bug dude
class_name Mob
extends CharacterBody2D

@onready var state_machine: MobStateMachine = $MobStateMachine
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shader_material: ShaderMaterial = animated_sprite_2d.material as ShaderMaterial

var health: int = 50
var last_heading: String = "S"
var movement_speed: float = 250.0

func _ready() -> void:
	shader_material.set_shader_parameter("flash_modifier", 0)
	animations.speed_scale = 0.8
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func get_heading_to_player(player_position: Vector2) -> String:
	var direction_to_player: Vector2 = player_position - global_position
	
	if direction_to_player.length() == 0:
		return last_heading
	else:
		var directions := ["E", "SE", "S", "SW", "W", "NW", "N", "NE"]
		var angle: float = float(rad_to_deg(direction_to_player.angle()))
		if angle < 0:
			angle += 360
		
		var temp: float = round(angle / 45)
		var index: int = int(temp) % 8
		
		last_heading = directions[index]
		return last_heading

func apply_damage(damage: int) -> void:
	health -= damage
	damage_shader()
	if health <= 0:
		queue_free()

func damage_shader() -> void:
	shader_material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.1).timeout
	shader_material.set_shader_parameter("flash_modifier", 0)
