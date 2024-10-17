class_name Option_pause_menu
extends Control

##Containers
@onready var exit_button: Button = $MarginContainer/VBoxContainer/exit_button

##Signals
signal exit_options_menu

##Functions
func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)

##Callbacks
func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)#disables button after clicked until proscess true
	
