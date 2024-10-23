class_name AudioSliderSettings
extends Node

##Variables
var bus_index : int = 0

##Containers
@onready var audio_name_lbl : Label = $HBoxContainer/Audio_Name_Lbl
@onready var audio_num_lbl : Label = $HBoxContainer/Audio_Num_Lbl
@onready var h_slider : HSlider = $HBoxContainer/HSlider

##Exports
@export_enum("Master","Music","SFX","Menu","Dialogue") var bus_name : String

#region Functions
func on_value_changed(value : float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_label_text()

func get_bus_name_by_index():
	bus_index = AudioServer.get_bus_index(bus_name)

func set_name_label_text():
	audio_name_lbl.text = str(bus_name) + " Volume"

func set_audio_num_label_text():
	audio_num_lbl.text = str(h_slider.value * 100) + "%"

func set_slider_value():
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()
#endregion

##Callbacks
func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()
