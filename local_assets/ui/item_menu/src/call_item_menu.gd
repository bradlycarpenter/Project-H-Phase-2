extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func change_items() -> void:
	var hbox = get_node("PanelContainer/MarginContainer/HBoxContainer")
	hbox.refresh_item_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
