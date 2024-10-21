extends Control

@onready var stats_dmg: RichTextLabel = $MarginContainer/stats_dmg


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats_dmg.text = "0.5"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
