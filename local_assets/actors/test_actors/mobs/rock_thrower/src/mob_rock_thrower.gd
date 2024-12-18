extends Mob

@export var health_potion: PackedScene

@onready var state_machine: MobStateMachine = $MobStateMachine
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shader_material: ShaderMaterial = animated_sprite_2d.material as ShaderMaterial

var health: int = 100
var movement_speed: float = 250.0
signal killed

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func apply_damage(damage: int) -> void:
	health -= damage
	damage_shader()
	if health <= 0:
		if randi() % 100 < 20:
			var potion_instance = health_potion.instantiate()
			potion_instance.position = position
			get_parent().add_child(potion_instance)
		emit_signal("killed")
		queue_free()

func damage_shader() -> void:
	shader_material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(0.1).timeout
	shader_material.set_shader_parameter("flash_modifier", 0)
