extends CharacterBody2D

var movement_speed: float = 100.0
var follow_distance_threshold: float = 350.0  # Distance at which enemy starts following player
var path = []  # Holds the calculated navigation path
var map

@onready var player = $"../TestCharacter"

func _ready():
	call_deferred("setup_navserver")

func _physics_process(_delta):
	# Check the distance between the enemy and the player
	var distance_to_player: float = global_position.distance_to(player.global_position)
	
	if distance_to_player < follow_distance_threshold:
		_update_navigation_path(global_position, player.global_position)

	if path.size() > 0:
		_move_along_path(_delta)

func setup_navserver():
	# Create a navigation map and set it active
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	print("Map created:", map)  # Debugging print to check if map is created
	
	# Create a new navigation region and add it to the map
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	
	# Set the navigation mesh for the region
	var navigation_poly = $"../NavigationRegion2D".navigation_polygon
	if navigation_poly != null:
		NavigationServer2D.map_set_cell_size(map, navigation_poly.cell_size)
		NavigationServer2D.region_set_navigation_polygon(region, navigation_poly)
		print("Navigation polygon set:", navigation_poly)  # Debugging print
	else:
		print("Error: Navigation polygon is null")

func _update_navigation_path(start_position, end_position):
	# Ensure the map is valid before proceeding
	if map == null:
		return
		
	get_node("../Line2D").clear_points()
	for i in path:
		get_node("../Line2D").add_point(i)
	# Calculate the path using NavigationServer2D
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)
	
	if path.size() > 0:
		path.remove_at(0)  # Remove the starting position from the path if needed

func _move_along_path(delta):
	var walk_distance = movement_speed * delta
	var last_point = global_position

	while path.size() > 0:
		var distance_to_next_point = last_point.distance_to(path[0])

		if walk_distance <= distance_to_next_point:
			# Move towards the next point
			global_position = last_point.lerp(path[0], walk_distance / distance_to_next_point)
			return

		# If the distance is more than the next point, move to the next point and continue
		walk_distance -= distance_to_next_point
		last_point = path[0]
		path.remove_at(0)

	global_position = last_point
