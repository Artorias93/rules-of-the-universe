extends AnimatedSprite


onready var audio = get_node("/root/Audio")


func _ready():
	pass


func _on_Gioca_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			play('Gioca')
			audio.play_effects("choice")
			


func _on_Opzioni_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			play('Opzioni')
			audio.play_effects("choice")


func _on_Classifica_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			play('Classifica')
			audio.play_effects("choice")


func _on_Crediti_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			play('Crediti')
			audio.play_effects("choice")


func _on_Esci_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch:
		if event.pressed:
			play('Esci')
			audio.play_effects("choice")
