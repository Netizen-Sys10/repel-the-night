@tool
extends Sprite2D

	
func _process(delta):
	
	#Should only be called when changing zoom, not every Frame
	#zoom_changed()
	_on_item_rect_changed()
	

func zoom_changed():
	material.set_shader_parameter("y_zoom", get_viewport_transform().get_scale().y)


func _on_item_rect_changed():
	material.set_shader_parameter("scale", scale)
	
