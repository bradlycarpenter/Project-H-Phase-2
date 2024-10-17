extends HBoxContainer

@export var item1: Item
@export var item2: Item
@export var item3: Item

@onready var display_item1: Button = $Button
@onready var display_item2: Button = $Button2
@onready var display_item3: Button = $Button3
var item1_children
var item2_children
var item3_children

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item1_children = display_item1.get_children()
	item2_children = display_item2.get_children()
	item3_children = display_item3.get_children()
	setItems(display_item1, item1_children, item1)
	setItems(display_item2, item2_children, item2)
	setItems(display_item3, item3_children, item3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Legendary Text Effect = "[tornado radius=2 freq=4][color=yellow]" + item.name + "[/color][/tornado]"
# Epic Text Effect = "[wave amp=15 freq=8][color=purple]" + item.name + "[/color][/wave]"
func setItems(display_item, item_children, item):
	item_children[0].texture = item.icon
	item_children[0].expand = true
	item_children[1].text = item.name
	item_children[2].text = item.description
	display_item.icon = item.tier
