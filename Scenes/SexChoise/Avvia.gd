extends Button

var click = 0
onready var donna = get_node("../Donna")
onready var indietro = get_node("../Indietro")
onready var rect = get_node("../ColorRect")
onready var player = get_node("../ColorRect/AnimationPlayer")
onready var choice = get_node("../MissChoise")


func _ready():
	set_process(false)


func _process(delta):
	if choice.get_node("Timer").time_left == 0:
		choice.visible = not choice.visible
		get_node("../MissChoise/Timer").start(0.3)


func _on_Avvia_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if donna.pressed:
				click = 1
				rect.show()
				player.play("Fade-In")
			else:
				get_node("../MissChoise/Timer").start(0.01)
				set_process(true)


func _on_Donna_mouse_entered():
	choice.hide()
	set_process(false)
