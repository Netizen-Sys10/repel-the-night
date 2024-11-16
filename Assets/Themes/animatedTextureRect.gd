@tool
extends TextureRect
class_name AnimatedTextureRect

signal is_playing

@export var sprites: SpriteFrames:
	set(value):
		sprites = value
		if sprites == null:
			animation = ''
			texture = null
		notify_property_list_changed()

@export var autoplay: bool

var animation: String
var frame: int
var speed_scale: float

var refresh_rate: float = 1.0
var fps: float = 30.0

var playing: bool = false
var paused: bool = false


func _get_property_list():
	var properties = []

	if sprites != null:
		var property_usage = PROPERTY_USAGE_DEFAULT

		properties.append({
			"name": "Animation",
			"type": TYPE_STRING,
			"usage": property_usage, # See above assignment.
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(sprites.get_animation_names())
		})
		
		var frames = []
		if !animation.is_empty():
			for i in sprites.get_frame_count(animation):
				frames.append(i)
		properties.append({
			"name": "Frame",
			"type": TYPE_INT,
			"usage": property_usage, # See above assignment.
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": ",".join([str(frames.min()), str(frames.max())])
		})

		properties.append({
			"name": "Speed Scale",
			"type": TYPE_FLOAT,
			"usage": property_usage # See above assignment.
		})

	return properties

func _get(property: StringName):
	if property == &"Animation":
		return animation
	if property == &"Frame":
		return frame
	if property == &"Speed Scale":
		return speed_scale

func _set(property: StringName, value) -> bool:
	if property == &"Animation":
		animation = value
		notify_property_list_changed()
		return true
	if property == &"Frame":
		frame = value
		texture = sprites.get_frame_texture(animation, frame)
		return true
	if property == &"Speed Scale":
		speed_scale = value
		return true
	return false

func _property_can_revert(property: StringName) -> bool:
	if property == &"Animation":
		return true
	if property == &"Speed Scale":
		return true
	if property == &"Frame":
		return true
	return false

func _property_get_revert(property: StringName): # -> Variant() type
	if property == &"Animation":
		return sprites.get_animation_names()[0]
	if property == &"Speed Scale":
		return 1.0
	if property == &"Frame":
		return 0
	return null

func _ready():
	if !Engine.is_editor_hint():
		if sprites == null:
			return
		is_playing.connect(on_playing)

#		fps = sprites.get_animation_speed(animation)
#		refresh_rate = sprites.get_frame_duration(animation, frame)

		if autoplay:
			play()

func on_playing():
	if sprites == null or animation.is_empty():
		return
	while playing:
		while paused:
			await get_tree().process_frame
		if !sprites.has_animation(animation):
			playing = false
			assert(false, "Animation %s not found" % animation)
			break

		fps = sprites.get_animation_speed(animation)
		refresh_rate = sprites.get_frame_duration(animation, frame)

		await get_tree().create_timer((refresh_rate/fps)/speed_scale).timeout
		frame += 1
		var frame_count = sprites.get_frame_count(animation)
		if frame >= frame_count:
			frame = 0
			if not sprites.get_animation_loop(animation):
				playing = false
				break

#		fps = sprites.get_animation_speed(animation)
#		refresh_rate = sprites.get_frame_duration(animation, frame)

		texture = sprites.get_frame_texture(animation, frame)

func _notification(what):
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		notify_property_list_changed()

func play(animation_name: String = animation):
	if !playing:
		frame = 0
		animation = animation_name

#		fps = sprites.get_animation_speed(animation_name)
#		refresh_rate = sprites.get_frame_duration(animation_name, frame)

		playing = true
		emit_signal("is_playing")
	else:
		paused = false

func pause():
	paused = true

func stop():
	frame = 0
	playing = false
