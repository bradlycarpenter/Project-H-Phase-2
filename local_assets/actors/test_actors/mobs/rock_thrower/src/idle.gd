extends MobState

@export var follow_state: MobState
var follow_distance_threshold: float = 300.0

func _ready() -> void:
	return
	
func enter() -> void:
	# super()
	parent.animations.play(animation_name + "_" + parent.last_heading)

func process_frame(_delta: float) -> MobState:
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		var player: Player = players[0]
		var distance_to_player = parent.global_position.distance_to(player.global_position)
		
		if follow_distance_threshold > distance_to_player:
			return follow_state
			
	return

