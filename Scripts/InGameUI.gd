extends CanvasLayer

func _ready():
	EventManager.CreatedPicture.connect(OnCreatePicture)
	EventManager.ShotsLeftUpdate.connect(OnShotsLeftUpdate)
	
func OnCreatePicture(image):
	$Photo.texture = ImageTexture.create_from_image(image)
	$Photo.position.y = 337.5
	$Photo.scale = Vector2.ONE
	
	var tween = get_tree().create_tween()
	tween.tween_property($Photo, "position", Vector2($Photo.position.x, 1500), .1)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($Photo, "scale", Vector2(.2,.2), .1)

func OnShotsLeftUpdate(amount):
	$ShotsLeft.text = str(amount)
