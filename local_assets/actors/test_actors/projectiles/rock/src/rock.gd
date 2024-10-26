extends Area2D

var target_position: Vector2 
@onready var animations: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var tween = create_tween()
	var players = get_tree().get_nodes_in_group("player")
	animations.play("y_arc")
	
	if players.size() > 0:
		var player: Player = players[0]
		target_position = player.global_position
		print(target_position)
	
	tween.tween_property(self, "global_position", target_position, 1)
	await tween.finished
	queue_free()

func _on_body_entered(body: Player) -> void:
	body.apply_damage(10)
