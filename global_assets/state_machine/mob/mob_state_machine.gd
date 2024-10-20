class_name MobStateMachine
extends Node

@export var starting_state: MobState

var current_state: MobState

func init(parent: Mob) -> void:
	for child: MobState in get_children():
		child.parent = parent

	change_state(starting_state)

func change_state(new_state: MobState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state: MobState = current_state.process_physics(delta)

	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state: MobState = current_state.process_input(event)
	
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state: MobState = current_state.process_frame(delta)

	if new_state:
		change_state(new_state)
