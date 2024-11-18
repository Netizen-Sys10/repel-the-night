extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D

var speed = 100.0
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("move_left", "move_right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
	
func update_animation():
	
	animation_tree.set("parameters/Walk/blend_position", direction.x)
	
	
func update_facing_direction():
	
	#Flip Sprite and set correct offset (player is not centered)
	if direction.x > 0:
		sprite.flip_h = false
		sprite.offset.x = 17
	elif direction.x < 0:
		sprite.flip_h = true
		sprite.offset.x = -17
