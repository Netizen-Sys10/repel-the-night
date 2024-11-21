class_name CharacterStateMachine extends Node2D

@export var player : CharacterBody2D

@export var animation_tree: AnimationTree

# The initial state of the state machine.
@export var current_state : State

var states : Array[State]

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to.
func _ready():
	for child in get_children():
		if(child is State):
			
			states.append(child)
			# Set the states up with what they need to function
			child.player = player
			child.playback = animation_tree["parameters/playback"]
			
		else:
			push_warning("Child"+ child.name + "is not a State for CharachterStateMachine")
			
	switch_state(current_state)

##????	
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_state(current_state.next_state)
		
	current_state.state_process(delta)
	
# Change to the new state by first calling any exit logic on the current state.
func switch_state(new_state : State):
	if(current_state != null):
		current_state.exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.enter()
	
func check_if_can_move():
	return current_state.can_move	

func _input(event : InputEvent):
	current_state.state_input(event)
	
