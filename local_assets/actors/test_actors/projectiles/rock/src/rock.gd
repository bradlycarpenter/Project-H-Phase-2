extends Area2D

var target_position: Vector2 
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	var tween = create_tween()
	var players = get_tree().get_nodes_in_group("player")
	animations.play("y_arc")
	
	if players.size() > 0:
		var player: Player = players[0]
		target_position = player.global_position
	
	tween.tween_property(self, "global_position", target_position, 1)
	tween.parallel().tween_property(sprite, "rotation", 360, 1)
	await tween.finished
	sfx.play()
	await sfx.finished
	queue_free()

func _on_body_entered(body: Player) -> void:
	body.apply_damage(10)
