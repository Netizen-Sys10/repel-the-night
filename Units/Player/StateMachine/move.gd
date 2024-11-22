extends State

@export var run_state: State
@export var hit_state: State
@export var death_state: State
	
func state_input(event : InputEvent):
	
	if(event.is_action_pressed("shift")):
		return run_state
	
