extends Node

#idle timer
const idle_timer = 60.0

#timer before exit
const popup_menu_time = 3.0

@onready var game_timer: Timer = $"."
@onready var popup_timer: Timer = $PopupTimer
@onready var notification_menu: PopupPanel = $NotificationMenu

func _ready() -> void:
	
	game_timer.wait_time = idle_timer
	game_timer.one_shot = true
	game_timer.start()
	
	popup_timer.one_shot = true
	popup_timer.wait_time = popup_menu_time
	
	game_timer.timeout.connect(_on_IdleTimer_timeout)
	popup_timer.timeout.connect(_on_PopupTimer_timeout)
	
	
func _input(event: InputEvent) -> void:
	if event.is_pressed():
		game_timer.start()
		
func _on_IdleTimer_timeout():
	print("Returning to main menu due to inactivity.")
	notification_menu.visible = true
	popup_timer.start()
	await get_tree().create_timer(5).timeout
	notification_menu.visible = false


func _on_PopupTimer_timeout() -> void:
	get_tree().change_scene_to_file("res://local_assets/ui/main_menu/src/main_menu.tscn")
