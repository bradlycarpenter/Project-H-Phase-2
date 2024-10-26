class_name Mob
extends CharacterBody2D

var last_heading: String = "S"
var movement_speed: float = 250.0

func get_heading_to_player(player_position: Vector2) -> String:
	var direction_to_player: Vector2 = player_position - global_position
	
	if direction_to_player.length() == 0:
		return last_heading
	else:
		var directions := ["E", "SE", "S", "SW", "W", "NW", "N", "NE"]
		var angle: float = float(rad_to_deg(direction_to_player.angle()))
		if angle < 0:
			angle += 360
		
		var temp: float = round(angle / 45)
		var index: int = int(temp) % 8
		
		last_heading = directions[index]
		return last_heading