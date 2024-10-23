class_name MainMenu
extends Control

##Buttons
@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_button
@onready var multi_player_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/multi_player_button
@onready var option_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/option_button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button

##Sound
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $MusicStreamPlayer/AudioStreamPlayer2D

##Containers
@onready var margin_container: MarginContainer = $MarginContainer
@onready var pup_option_menu: SettingMenu = $pup_option_menu

##Export Scenes
@export_file var single_lvl: String
@export_file var multiplayer_lvl: String 

#region Functions
func on_start_pressed() -> void:
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file(single_lvl)
	
func on_multi_player_button() -> void:
	audio_stream_player_2d.play()
	get_tree().change_scene_to_file(multiplayer_lvl)
	
func on_exit_pressed() -> void:
	audio_stream_player_2d.play()
	get_tree().quit()

func on_option_pressed() -> void:
	margin_container.visible = false
	pup_option_menu.set_process(true)
	pup_option_menu.visible = true
	audio_stream_player_2d.play()

func on_exit_option_menu() -> void:
	margin_container.visible = true
	pup_option_menu.visible = false
#endregion

#Connections
func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	multi_player_button.button_down.connect(on_multi_player_button)
	option_button.button_down.connect(on_option_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	pup_option_menu.exit_options_menu.connect(on_exit_option_menu)

#Callbacks
func _ready():
	handle_connecting_signals()
