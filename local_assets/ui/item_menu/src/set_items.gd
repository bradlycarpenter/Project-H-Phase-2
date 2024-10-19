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

var item1_children
var item2_children
var item3_children

var rarities = {"Uncommon": 60,
				"Rare": 25,
				"Epic": 10,
				"Legendary": 5}
				
var items_by_tier = {
	"Uncommon": [],
	"Rare": [],
	"Epic": [],
	"Legendary": []
}

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	categorize_items()
	
	var random_rarities = []
	for n in 3:
		random_rarities.append(get_rarity())
	
	var selected_items = []
	for rarity in random_rarities:
		selected_items.append(get_random_item_by_rarity(rarity))
	
	item1_children = display_item1.get_children()
	item2_children = display_item2.get_children()
	item3_children = display_item3.get_children()
	setItems(display_item1, item1_children, selected_items[0])
	setItems(display_item2, item2_children, selected_items[1])
	setItems(display_item3, item3_children, selected_items[2])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Legendary Text Effect = "[tornado radius=2 freq=4][color=yellow][center]" + item.name + "[/center][/color][/tornado]"
# Epic Text Effect = "[wave amp=15 freq=8][color=purple][center]" + item.name + "[/center][/color][/wave]"
func setItems(display_item, item_children, item):
	item_children[0].texture = item.icon
	item_children[0].expand = true
	item_children[1].text = "[center]" + item.name + "[/center]"
	item_children[2].text = "[center]" + item.description + "[/center]"
	display_item.icon = item.tierColor

func get_rarity():
	rng.randomize()
	
	var weighted_sum = 0 
	
	for n in rarities:
		weighted_sum += rarities[n]
		
	var item = rng.randi_range(0, weighted_sum)
	
	for n in rarities:
		if item <= rarities[n]:
			return n
		item -= rarities[n]

func categorize_items():
	var all_items = [item1, item2, item3, item4, item5, item6, item7]
	for item in all_items:
		if item.tier in items_by_tier:
			items_by_tier[item.tier].append(item)

# Function to see what items are in what rarity
func print_items():
	for tier in items_by_tier.keys():
		print("Tier:", tier)
		for item in items_by_tier[tier]:
			print("- Item:", item.name)
			
func get_random_item_by_rarity(rarity):
	var items = items_by_tier[rarity]
	if items.size() > 0:
		return items[rng.randi_range(0, items.size() -1)]
	return null
