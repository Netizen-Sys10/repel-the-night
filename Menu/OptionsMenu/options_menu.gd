class_name OptionsMenu
extends Control

func enter() -> void:
	pass

func exit() -> void:
	pass

func _on_exit_pressed() -> void:
	if get_parent().has_method("_pop_and_push"):
		get_parent()._pop_and_push("TitleMenu")
