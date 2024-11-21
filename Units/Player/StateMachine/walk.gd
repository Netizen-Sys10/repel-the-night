extends State

func process_physics(delta: float) -> State:
	
	var movement = Input.get_axis("move_left", "move_right") * player.speed
	
	if movement == 0:
		return idle_state
	
	player.velocity.x = movement
	player.move_and_slide()
	
	return null
