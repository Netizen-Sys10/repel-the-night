extends Node
# Responsible for instantiating and deleting scenes. Currently doesn't support hiding scenes when a new one is added

signal main_menu_exited(next_mode)

var current_scene : Node
var scene_stack : Array
var scenes  : Dictionary = {
	"TitleMenu" : load("res://Menu/TitleMenu/title_menu.tscn"),
	"OptionsMenu" : load("res://Menu/OptionsMenu/options_menu.tscn"),
	"ControlsMenu" : load("res://Menu/ControlsMenu/controls_menu.tscn"),
	"ProfilesMenu" : load("res://Menu/ProfilesMenu/profiles_menu.tscn")
	}


func _ready():
	if get_parent().has_method("_pop_and_push"):
		main_menu_exited.connect(get_parent()._pop_and_push)
	_push_scene("TitleMenu")

func _pop_scene():
	if not scene_stack.size() > 0:
		return
	if scene_stack[0].has_method("exit"):
		scene_stack[0].exit()
	current_scene.queue_free()
	scene_stack.pop_front()
	pass

func _push_scene(next_scene : String):
	current_scene = scenes[next_scene].instantiate()
	scene_stack.push_front(current_scene)
	add_child(current_scene)
	if scene_stack[0].has_method("enter"):
		scene_stack[0].enter()
	pass

func _pop_and_push(next_scene : String) -> void:
	_pop_scene()
	_push_scene(next_scene)

func _on_run_started() -> void:
	emit_signal("main_menu_exited", "run")


func _on_run_continued() -> void:
	emit_signal("main_menu_exited", "run")
