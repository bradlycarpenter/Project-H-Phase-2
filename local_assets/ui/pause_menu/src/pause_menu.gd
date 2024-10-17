extends Control

##Containers
@onready var margin_container: MarginContainer = $MarginContainer
@onready var option_pause_menu: Option_pause_menu = $option_pause_menu

##Exports
@export_file("*.tscn") var main_menu

#region Functions

func resume():
	margin_container.visible = false
	get_tree().paused = false
	
func pause():
	margin_container.visible = true
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("p1_select") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("p1_select") and get_tree().paused:
		resume()
		
func change_a_scene_manually():
#endregion
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu)
	
#region Connections
func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_button_pressed() -> void:
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
