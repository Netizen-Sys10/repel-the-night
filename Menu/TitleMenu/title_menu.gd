extends Control


func _on_start_pressed() -> void:
	if get_parent().has_method("_on_run_started"):
		get_parent()._on_run_started()

func _on_options_pressed() -> void:
	if get_parent().has_method("_pop_and_push"):
		get_parent()._pop_and_push("OptionsMenu")

func _on_controls_pressed() -> void:
	if get_parent().has_method("_push_scene"):
		get_parent()._push_scene("ControlsMenu")

func _on_profiles_pressed() -> void:
	if get_parent().has_method("_push_scene"):
		get_parent()._push_scene("ProfilesMenu")

func _on_exit_pressed() -> void:
	get_tree().quit()
