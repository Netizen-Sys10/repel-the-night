extends State

@export var run_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("shift")):
		run()
		
func run():
	character.speed = 200
	next_state = run_state
	playback.travel("run")
