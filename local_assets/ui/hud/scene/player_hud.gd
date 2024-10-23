class_name PlayerHUD
extends Control

#HP_Bar
@onready var hp_bar: ProgressBar = $MarginContainer/HBoxContainer/hp_bar

##Labels
@onready var stats_crit: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_crit
@onready var stats_move_speed: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_move_speed
@onready var stats_attack_speed: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_attack_speed
@onready var stats_defense: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_defense
@onready var stats_dash_count: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_dash_count
@onready var stats_cd_reduction: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_cd_reduction
@onready var stats_shield: Label = $MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/stats_shield

#Data
@export var stats: Stats

func player_hud_stats():
	
	#hp_bar
	var hp_value: int = stats.current_health
	hp_bar.value = hp_value
	
	#crit
	var crit_chance: float = stats.crit_chance
	stats_crit.text = str(crit_chance)
	
	#movement speed
	var move_speed: float = stats.move_speed
	stats_move_speed.text = str(move_speed)
	
	#attack speed
	var attack_speed: float = stats.attack_speed
	stats_attack_speed.text = str(attack_speed)
	
	#defense
	var defense: float = stats.defense
	stats_defense.text = str(defense)
	
	#dsh count
	var dash: int = stats.dash_count
	stats_dash_count.text = str(dash)
	
	#cooldownredyction
	var cooldown_reduction: float = stats.cooldown_reduction
	stats_cd_reduction.text = str(cooldown_reduction)
	
	#sheild
	var shield: float = stats.shield
	stats_shield.text = str(shield)

func _process(_delta: float) -> void:
	player_hud_stats()
	
