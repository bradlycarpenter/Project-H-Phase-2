class_name MobState
extends Node

@export var animation_name: String

var parent: Mob

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> MobState:
	return null

func process_frame(_delta: float) -> MobState:
	return null

func process_physics(_delta: float) -> MobState:
	return null
