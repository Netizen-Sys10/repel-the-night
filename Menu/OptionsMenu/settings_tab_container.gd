class_name SettingsTabContainer 
extends Control

@onready var tab_container = $TabContainer as TabContainer


func _ready() -> void:
	tab_container.get_tab_bar().grab_focus()

func _get_tab_id() -> int:
	return tab_container.get_tab_idx_from_control(tab_container.get_current_tab_control())

# If the first tab is selected and the left arrow key is pressed, then select the last tab
func _check_left_on_first_tab(event : InputEvent) -> void:
	if not _get_tab_id() == 0: return
	if not event.is_action_pressed("ui_left"): return
	tab_container.set_current_tab(tab_container.get_tab_count()-1)

# If the last tab is selected and the right arrow key is pressed, then select the first tab
func _check_right_on_last_tab(event : InputEvent) -> void:
	if not _get_tab_id() == tab_container.get_tab_count()-1: return
	if not event.is_action_pressed("ui_right"): return
	tab_container.set_current_tab(0)

func _unhandled_input(event: InputEvent) -> void:
	_check_left_on_first_tab(event)
	_check_right_on_last_tab(event)
