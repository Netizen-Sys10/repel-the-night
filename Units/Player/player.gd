class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D

var speed = 100.0
var direction : Vector2 = Vector2.ZERO

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("move_left", "move_right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
# Updates the Player Animation	
func update_animation():
	
	var run : bool = false
	
	if Input.is_action_pressed("shift") && velocity:
		run = true
	
	animation_tree.set("parameters/conditions/run", run)
	animation_tree.set("parameters/conditions/normal", !run)
	
	animation_tree.set("parameters/Walk/blend_position",direction.x)
	animation_tree.set("parameters/Run/blend_position",direction.x)

# Updates the Facing Direction of the Player	
func update_facing_direction():
	
	#Flip Sprite and set correct offset (player is not centered)
	if direction.x > 0:
		sprite.flip_h = false
		sprite.offset.x = 17
	elif direction.x < 0:
		sprite.flip_h = true
		sprite.offset.x = -17
