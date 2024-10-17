extends Node2D

@export var item: Item

func _ready():
	pass

func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.adjust_stat("speed", item.stat_boost["speed"]) # Can be changed according to the attached item
		queue_free()
