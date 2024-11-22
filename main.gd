extends Node
# Instantiates and deletes game modes. Game modes are systems grouped in a scene
# Each mode has an enter() and exit() function, since some of them need to pause the game_tree

@export var fps_label : Label

var mode_stack : Array[Node]
var current_mode : Node
var modes : Dictionary = {
	"main_menu" : load("res://Menu/menu.tscn"),
	"run" : load("res://Levels/Run/run.tscn")
}


func _ready():
	_push_mode("main_menu")


func _push_mode(mode : String):
	current_mode = modes[mode].instantiate()
	mode_stack.push_front(current_mode)
	add_child(current_mode)
	if mode_stack[0].has_method("enter"):
		mode_stack[0].enter()
	pass


func _pop_mode():
	if not mode_stack.size() > 0:
		return
	if mode_stack[0].has_method("exit"):
		mode_stack[0].exit()
	current_mode.queue_free()
	mode_stack.pop_front()
	pass


func _pop_and_push(next_mode : String) -> void:
	_pop_mode()
	_push_mode(next_mode)


func _clear_and_push(next_mode : String) -> void:
	if mode_stack[0].has_method("exit"):
		mode_stack[0].exit()
	current_mode.queue_free()
	mode_stack = [] #This clears all remaining modes without calling their exit function
	_push_mode(next_mode)
	pass


func _process(_delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
