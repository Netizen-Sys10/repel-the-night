class_name TitleMenu

extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/ExitButton as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/OptionsButton as Button
@onready var margin_container = $MarginContainer as MarginContainer
@export var start_level = preload("res://Game/game.tscn") as PackedScene

func enter() -> void:
	pass

func exit() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_options_pressed() -> void:
	if get_parent().has_method("change_to"):
		get_parent().change_to("OptionsMenu")
	
func on_exit_pressed() -> void:
	get_tree().quit()


func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
