extends HBoxContainer

@export var item1: Item
@export var item2: Item
@export var item3: Item
@export var item4: Item
@export var item5: Item
@export var item6: Item
@export var item7: Item

@onready var display_item1: Button = $Button
@onready var display_item2: Button = $Button2
@onready var display_item3: Button = $Button3

var item1_children: Array
var item2_children: Array
var item3_children: Array

var selected_items: Array[Item] = []

var rarities: Dictionary = {
	"Uncommon": 60,
	"Rare": 25,
	"Epic": 10,
	"Legendary": 5
}

var items_by_tier: Dictionary = {
	"Uncommon": [],
	"Rare": [],
	"Epic": [],
	"Legendary": []
}

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	categorize_items()
	refresh_item_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Legendary Text Effect = "[tornado radius=2 freq=4][color=yellow][center]" + item.name + "[/center][/color][/tornado]"
# Epic Text Effect = "[wave amp=15 freq=8][color=purple][center]" + item.name + "[/center][/color][/wave]"
func setItems(display_item: Button, item_children: Array, item: Item) -> void:
	item_children[0].texture = item.icon
	item_children[0].expand = true
	item_children[1].text = "[center]" + item.name + "[/center]"
	item_children[2].text = "[center]" + item.description + "[/center]"
	display_item.icon = item.tierColor

func refresh_item_menu() -> void:
	selected_items.clear()  # Clear previously selected items
	var random_rarities: Array = []
	for n in range(3):
		random_rarities.append(get_rarity())
	
	for rarity: String in random_rarities:
		var item: Item = get_random_item_by_rarity(rarity)
		selected_items.append(item)
	
	item1_children = display_item1.get_children()
	item2_children = display_item2.get_children()
	item3_children = display_item3.get_children()
	setItems(display_item1, item1_children, selected_items[0])
	setItems(display_item2, item2_children, selected_items[1])
	setItems(display_item3, item3_children, selected_items[2])

func get_rarity() -> String:
	rng.randomize()

	var weighted_sum: int = 0

	for rarity: String in rarities.keys():
		weighted_sum += rarities[rarity]

	var item: int = rng.randi_range(0, weighted_sum)

	for rarity: String in rarities.keys():
		if item <= rarities[rarity]:
			return rarity
		item -= rarities[rarity]
	return "null"

func categorize_items() -> void:
	var all_items: Array = [item1, item2, item3, item4, item5, item6, item7]
	for item: Item in all_items:
		if item.tier in items_by_tier:
			var item_list: Array = items_by_tier[item.tier]
			if item_list is Array:
				item_list.append(item)

# Function to see what items are in what rarity
func print_items() -> void:
	for tier: String in items_by_tier.keys():
		print("Tier:", tier)
		for item: Item in items_by_tier[tier]:
			print("- Item:", item.name)
			
func get_random_item_by_rarity(rarity: String) -> Item:
	var items: Array = items_by_tier[rarity]
	if items.size() > 0:
		return items[rng.randi_range(0, items.size() -1)]
	return null

func _on_button_pressed() -> void:
	var selected_item = selected_items[0].stat_boost
	var player = get_tree().get_nodes_in_group("player")[0]
	selected_items[0].apply_effect(player)

func _on_button_2_pressed() -> void:
	var selected_item = selected_items[0].stat_boost
	var player = get_tree().get_nodes_in_group("player")[0]
	selected_items[1].apply_effect(player)

func _on_button_3_pressed() -> void:
	var selected_item = selected_items[0].stat_boost
	var player = get_tree().get_nodes_in_group("player")[0]
	selected_items[2].apply_effect(player)
