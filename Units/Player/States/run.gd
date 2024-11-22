extends State

@export var move_state: State
@export var hit_state: State
@export var death_state: State

func update(_delta):
	pass

func normal():
	player.speed = 100
