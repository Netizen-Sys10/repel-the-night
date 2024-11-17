extends Node
# Responsible for instantiating and deleting nodes. Currently only one menu is supposed to be active at a time

signal main_menu_exited(next_mode)

var current_scene : Node
var scene_stack : Array
var scenes  : Dictionary = {
	"FirstLevel" : load("res://Run/first_level.tscn"),
	}


func _ready():
	if get_parent().has_method("_pop_and_push"):
		main_menu_exited.connect(get_parent()._pop_and_push)
	_push_scene("FirstLevel")

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
