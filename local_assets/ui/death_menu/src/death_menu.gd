class_name DeathMenu
extends Control


@export var main_menu: PackedScene
@onready var deathmenu: DeathMenu = $"."


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	deathmenu.visible = false
	get_tree().reload_current_scene()
	
	


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
	
