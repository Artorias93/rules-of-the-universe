extends Button

var click = 0
onready var rect = get_node("../ColorRect")
onready var player = get_node("../ColorRect/AnimationPlayer")

func _ready():
	click = 0


func _on_Indietro_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			click = 1
			rect.show()
			player.play("Fade-In")
	
