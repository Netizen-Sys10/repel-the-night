extends Node
# Responsible for instantiating and deleting nodes. Currently only one menu is supposed to be active at a time

signal main_menu_exited(next_mode)

var current_menu : Node
var history : Array[String]
var menus  : Dictionary = {
	"TitleMenu" : load("res://MainMenu/TitleMenu/title_menu.tscn"),
	"OptionsMenu" : load("res://MainMenu/OptionsMenu/options_menu.tscn"),
	"ControlsMenu" : load("res://MainMenu/ControlsMenu/controls_menu.tscn")
	}

func enter() -> void:
	pass


func exit() -> void:
	pass


func _ready():
	if get_parent().has_method("_pop_and_push"):
		main_menu_exited.connect(get_parent()._pop_and_push)
	current_menu = menus["TitleMenu"].instantiate()
	add_child(current_menu)
	current_menu.enter()


# For switching submenus
func change_to(next_menu : String) -> void:
	history.append(current_menu.name) # Only saving the string name of the menu, not the actual node
	_set_menu(next_menu)
	pass

# Only for submenus with a back button
func back() -> void:
	if history.size() > 0:
		_set_menu(history.pop_back())


func _set_menu(next_menu : String) -> void:
	if not current_menu == null:
		current_menu.queue_free()
	current_menu = menus[next_menu].instantiate()
	add_child(current_menu)
	current_menu.enter()


func _on_run_started() -> void:
	emit_signal("main_menu_exited", "run")


func _on_run_continued() -> void:
	emit_signal("main_menu_exited", "run")
