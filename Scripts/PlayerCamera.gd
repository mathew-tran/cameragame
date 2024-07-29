extends Node2D



func IsTakingPicture():
	return $Camera2D.enabled
	
func _process(delta):
	
	if IsTakingPicture():
		return
	
	global_position = get_global_mouse_position()

	if Input.is_action_just_pressed("Click"):
		TakeSnapshot()
		
func TakeSnapshot():
	$Camera2D.enabled = true

	await RenderingServer.frame_post_draw
	var capture = $Camera2D.get_viewport().get_texture().get_image()
	
	var _time = Time.get_datetime_string_from_system().replace(":", "-")
	var filename = "user://Screenshot-{0}.png".format({"0":_time})
	capture.save_png(filename)
