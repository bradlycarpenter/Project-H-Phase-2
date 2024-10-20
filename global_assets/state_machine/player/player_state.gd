class_name PlayerState
extends Node

@export var animation_name: String

var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> PlayerState:
	return null

func process_frame(_delta: float) -> PlayerState:
	return null

func process_physics(_delta: float) -> PlayerState:
	return null
