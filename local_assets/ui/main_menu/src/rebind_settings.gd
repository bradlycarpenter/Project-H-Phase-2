extends Control

##Resource
const input_button = preload("res://local_assets/ui/main_menu/src/input_button.tscn")

##Containers
@onready var action_list: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

##Variables
var is_remapping = false 
var action_to_remap = null
var remapping_buton = null


#region Data Structure
var input_actions = {
	"p1_move_up": "Move Up",
	"p1_move_down": "Move Down",
	"p1_move_left": "Move Left",
	"p1_move_right": "Move Right",
	"p1_attack_primary": "Attack Primary",
	"p1_attack_secondary": "Attack Secondary",
	"p1_attack_special": "Attack Special",
	"p1_dodge": "Dodge"
}
#endregion

#region Functions
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events .size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true 
		action_to_remap = action
		remapping_buton = button
		button.find_child("LabelInput").text = "Press Key to bind"

func _input(event):
	if is_remapping:
		if(event is InputEventKey || event is InputEventMouseButton && event.pressed):
				if event is InputEventMouseButton && event.double_click:
					event.double_click = false
				
				InputMap.action_erase_events(action_to_remap)
				InputMap.action_add_event(action_to_remap, event)
				_update_action_list(remapping_buton, event)
				
				is_remapping = false 
				action_to_remap = null
				remapping_buton = null
				
				accept_event()

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
#endregion
		
##Connections
func _on_reset_button_pressed() -> void:
	_create_action_list()
	
##Callbacks
func _ready() -> void:
	_create_action_list()
