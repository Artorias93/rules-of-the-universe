extends Control


export var rotation_speed = PI
onready var sat = $Sat/Sat


func _ready():
	$Rect/ColorRect.color = Color(0,0,0,255)
	$Rect/ColorRect.show()
	$Rect/ColorRect/AnimationPlayer.play("Fade-Out")


func _process(delta):
	$Logo/Ufo.rotation += rotation_speed *0.2* delta
	sat.set_offset(sat.get_offset() + 50 * -delta)
