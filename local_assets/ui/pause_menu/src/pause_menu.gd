extends CanvasLayer

##Containers
@onready var option_pause_menu: Option_pause_menu = $option_pause_menu
@onready var margin_container: CanvasLayer = $"."

##Exports
@export_file var main_menu: String
@export var stats: Stats

#region Functions

func resume():
	margin_container.visible = false
	get_tree().paused = false
	
func pause():
	margin_container.visible = true
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("p1_start") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("p1_start") and get_tree().paused:
		resume()
		
func change_a_scene_manually():
#endregion
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu)
	
#region Connections
func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_button_pressed() -> void:
	
	#resets stats
	stats.current_health = 100
	stats.base_damage = 0
	stats.crit_chance = 0.1
	stats.move_speed = 200
	stats.attack_speed = 1
	stats.defense = 0
	stats.dash_count = 1
	stats.cooldown_reduction = 0
	stats.double_hit_chance = 0
	stats.shield = 0
	stats.dash_attack = false
	
	resume()
	get_tree().reload_current_scene()
	
func _on_option_button_pressed() -> void:
	margin_container.visible = false
	option_pause_menu.set_process(true)
	option_pause_menu.visible = true

func on_exit_option_menu() -> void:
	margin_container.visible = true
	option_pause_menu.visible = false
	
func _on_exit_button_pressed() -> void:
	change_a_scene_manually()
	
func handle_connecting_signals() -> void:
#endregion
	option_pause_menu.exit_options_menu.connect(on_exit_option_menu)

##Callbacks
func _ready() -> void:
	handle_connecting_signals()
	
func _process(_delta):
	testEsc()
