class_name SettingsTabContainer 
extends Control

@onready var tab_container = $TabContainer as TabContainer
#signal options_menu_exited


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


#func _process(delta):
	#options_menu_input()
#
#func change_tab(tab : int) -> void:
	#tab_container.set_current_tab(tab)
	
#func options_menu_input() -> void:
	#if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		#if tab_container.current_tab >= tab_container.get_tab_count()-1:
			#change_tab(0)
			#return
		#
		#var next_tab = tab_container.current_tab + 1
		#change_tab(next_tab)
	#if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		#if tab_container.current_tab == 0:
			#change_tab(tab_container.get_tab_count() - 1 )
			#return
			#
		#var previous_tab = tab_container.current_tab - 1
		#change_tab(previous_tab)
		#
	#if Input.is_action_just_pressed("ui_cancel"):
		#options_menu_exited.emit()
			
