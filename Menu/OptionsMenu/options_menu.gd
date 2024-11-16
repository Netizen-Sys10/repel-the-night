extends Control

@export var options_btn : OptionButton
@export var fullscreen_btn : CheckBox

func _ready():
	if UserConfig.current_settings["display"].fullscreen == true:
		fullscreen_btn.set_pressed_no_signal(true)
	_update_window_size_display()
	pass

func _on_option_button_item_selected(index):
	EventBus.emit_signal("window_size_changed", index)
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_exit_pressed()

func _on_exit_pressed() -> void:
	if get_parent().has_method("_pop_and_push"):
		get_parent()._pop_and_push("TitleMenu")

func _update_window_size_display():
	for i in options_btn.item_count:
		var text = options_btn.get_item_text(i)
		var values = text.split_floats("x")
		var current_item = UserConfig.current_settings["display"].window_size
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
				options_btn.select(current_item)
				break
		elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			if DisplayServer.screen_get_size() == Vector2i(int(values[0]), int(values[1])):
				options_btn.select(i)
				break
			else:
				options_btn.select(current_item)


func _on_window_mode_toggled(toggled_on: bool) -> void:
	EventBus.emit_signal("window_mode_toggled", toggled_on)
	pass # Replace with function body.
