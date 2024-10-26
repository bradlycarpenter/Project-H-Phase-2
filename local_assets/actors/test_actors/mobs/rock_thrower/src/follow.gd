
extends MobState

@export var idle_state: MobState
@export var attack_state: MobState
@export var throw_state: MobState

var follow_distance: float = 4000

var path: Array = []
var map: RID
var dir: String

var attack_distance: float = 300

func enter() -> void:
	call_deferred("setup_navserver")
	return

func process_frame(_delta: float) -> MobState:
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		var player: Player = players[0]
		var distance_to_player: float = parent.global_position.distance_to(player.global_position)
		
		if attack_distance > distance_to_player:
			return throw_state
		
		var heading:String = parent.get_heading_to_player(player.global_position)
		parent.animations.play(animation_name + "_" + heading)
		
		_update_navigation_path(parent.global_position, player.global_position)
		
		if path.size() > 0:
			_move_along_path(_delta)
		
		if follow_distance < distance_to_player:
			return idle_state
	return


func setup_navserver():
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)

	var region: RID = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)

	var nav_regions = get_tree().get_nodes_in_group("navigation_regions")

	for nav_region in nav_regions:
		if nav_region is NavigationRegion2D:
			var navigation_poly: NavigationPolygon = nav_region.navigation_polygon
			if navigation_poly != null:
				NavigationServer2D.map_set_cell_size(map, float(navigation_poly.cell_size))
				NavigationServer2D.region_set_navigation_polygon(region, navigation_poly)
				return

func _update_navigation_path(start_position: Vector2, end_position: Vector2):
	if map == null:
		return
		
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)
	
	if path.size() > 0:
		path.remove_at(0) 

func _move_along_path(delta):
	var walk_distance: float = parent.movement_speed * delta
	var last_point: Vector2 = parent.global_position
	var next_point: Vector2

	while path.size() > 0:
		if path[0] is Vector2:
			next_point = path[0]
			
		var distance_to_next_point: float = last_point.distance_to(next_point)

		if walk_distance <= distance_to_next_point:
			parent.global_position = last_point.lerp(next_point, float(walk_distance) / distance_to_next_point)
			return

		walk_distance -= distance_to_next_point
		last_point = next_point
		path.remove_at(0)

	parent.global_position = last_point
