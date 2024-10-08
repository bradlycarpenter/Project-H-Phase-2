extends Node2D

@export var item: Item

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"): # Assuming your player is in a group named "player"
		body.adjust_stat("health", item.stat_boost["health"]) # Adjust the health using the item's effect
		print("Health: "  + str(body.health))
		queue_free() # Remove the item from the scene
