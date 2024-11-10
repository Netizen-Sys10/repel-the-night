class_name OptionsMenu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button
@onready var settings_tab_container = $MarginContainer/VBoxContainer/Settings_Tab_Container as SettingsTabContainer

func enter() -> void:
	pass

func exit() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	exit_button.button_down.connect(on_exit_pressed)

func on_exit_pressed() -> void:
	if get_parent().has_method("back"):
		get_parent().back()
