# Virtual base class for all states.
class_name State extends Node

@export var animation_name: String
@export var can_move : bool = true

var player : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback

var next_state : State

# Called by the state machine when receiving unhandled input events.
func state_input(_event : InputEvent):
	pass
	
func state_process(delta):
	pass
	
# Called when the state becomes active.
func enter() -> void:
	playback.travel(animation_name)

# Called by the state machine before changing the active state. 
# Use this function to clean up the state.
func exit():
	pass
