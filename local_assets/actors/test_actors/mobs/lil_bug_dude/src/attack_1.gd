extends MobState

@export var idle_state: MobState
@export var follow_state: MobState

var follow_distance: float = 70.0

func process_frame(_delta: float) -> MobState:
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		var player: Player = players[0]
		var distance_to_player: float = parent.global_position.distance_to(player.global_position)
		
		if distance_to_player > follow_distance:
			return follow_state
		
		var heading:String = parent.get_heading_to_player(player.global_position)
		parent.animations.play(animation_name + "_" + heading)
	return


func _on_hitbox_body_entered(body: Player) -> void:
	body.apply_damage(10)
