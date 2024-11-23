extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_exit_pressed()

func _on_exit_pressed() -> void:
	if get_parent().has_method("_pop_and_push"):
		get_parent()._pop_and_push("TitleMenu")
