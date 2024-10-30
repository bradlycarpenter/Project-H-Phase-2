class_name DeathMenu
extends CanvasLayer

@export_file var main_menu: String

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu)
	
