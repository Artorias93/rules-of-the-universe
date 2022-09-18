extends KinematicBody2D

var anim = 0
var posy = 0
var posx = 0
var speed = Vector2()
var dist = 1150
var idclick = null
var listposy = [1196, 1334, 1471, 1609, 1746]
onready var rect = get_node("../Rect/ColorRect")
onready var player = get_node("../Rect/ColorRect/AnimationPlayer")


func _ready():
	set_process(false)


func _process(delta):
	if self.position.x > dist:
		speed = Vector2(-1,0)
	else: 
		speed = Vector2(0,0)
		$Rocket.scale = Vector2(0.250,0.250)
		$Rocket.play('Explosion')
		
# warning-ignore:return_value_discarded
	move_and_collide(speed.normalized()*600*delta)
	
	if $Rocket.animation == "Explosion" and $Rocket.frame == 2: 
		anim = 1
		rect.show()
		player.play("Fade-In")


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim == 1:
		if idclick == 0: SceneManager.goto_scene("res://Scenes/SexChoise/SexChoise.tscn")
		if idclick == 1: SceneManager.goto_scene("res://Scenes/Options/Options.tscn")
		elif idclick == 2: SceneManager.goto_scene("res://Scenes/HighScore/HighScore.tscn")
		elif idclick == 3: SceneManager.goto_scene("res://Scenes/Credits/Credits.tscn")
		elif idclick == 4: get_tree().quit()
	else:
		rect.hide()


# warning-ignore:return_value_discarded
func click(event):
	if event is InputEventScreenTouch:
		if event.pressed and posy in listposy:
			get_parent().set_mouse_filter(1)
			self.position = Vector2(0,0)
			$Rocket.scale = Vector2(1,1)
			$Rocket.play('Launch')
			show()
			$Rocket.position = Vector2(1150,posy)
			dist =  -1150 + posx
			set_process(true)


func _on_Gioca_input_event(_viewport, event, _shape_idx):
	posy = 1196
	posx = 500
	idclick = 0
	click(event)


func _on_Opzioni_input_event(_viewport, event, _shape_idx):
	posy = 1334
	posx = 460
	idclick = 1
	click(event)


func _on_Classifica_input_event(_viewport, event, _shape_idx):
	posy = 1471
	posx = 377
	idclick = 2
	click(event)


func _on_Crediti_input_event(_viewport, event, _shape_idx):
	posy = 1609
	posx = 465
	idclick = 3
	click(event)


func _on_Esci_input_event(_viewport, event, _shape_idx):
	posy = 1746
	posx = 533
	idclick = 4
	click(event)



