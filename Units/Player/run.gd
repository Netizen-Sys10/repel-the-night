extends State

@export var normal_state : State

func state_process(delta):
	pass

func normal():
	character.speed = 100
	next_state = normal_state
	#playback.travel("nomal")
