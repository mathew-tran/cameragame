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
	var image = capture.duplicate()
	var _time = Time.get_datetime_string_from_system().replace(":", "-")
	var filename = "user://Screenshot-{0}.png".format({"0":_time})
	capture.save_png(filename)
	await get_tree().create_timer(.4).timeout
	EventManager.CreatedPicture.emit(image)
	var pictureData = {}
	var areasHit = $Area2D.get_overlapping_areas()
	pictureData["imageFile"] = filename
	var accuracy = 0
	if len(areasHit) > 0:
		areasHit[0]
		pictureData["Cloud"] = areasHit[0]
		var distance = $Camera2D.global_position.distance_to(areasHit[0].global_position)
		var maxDistance = 300
		if distance > maxDistance:
			distance = maxDistance
		accuracy = lerp(100, 0, distance / maxDistance)
		
	else:
		pictureData["Cloud"] = null
		
	pictureData["Accuracy"] = accuracy
	EventManager.PictureDataSent.emit(pictureData)
	$Camera2D.enabled = false
