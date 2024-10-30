extends Node2D

@export var stats: Stats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body.is_in_group("player"):
		if stats.current_health == 100:
			stats.current_health = 100
		else:
			stats.current_health += 10
		queue_free()
