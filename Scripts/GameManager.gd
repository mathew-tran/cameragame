extends Node

var PicturesToTake = 20

func _ready():
	EventManager.CreatedPicture.connect(OnCreatedPicture)
	EventManager.ShotsLeftUpdate.emit(PicturesToTake)


func OnCreatedPicture(_image):
	PicturesToTake -= 1
	if PicturesToTake < 0:
		PicturesToTake = 0
	EventManager.ShotsLeftUpdate.emit(PicturesToTake)
