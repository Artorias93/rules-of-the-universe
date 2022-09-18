extends Control

var ost = load("res://Utility/Theme.ogg")
#var slide = load("")
#var malus = load("")
#var bonus = load("")
#var bias = load("")

func _ready():

	pass

func _process(delta):
	#print($Timer.time_left)
	#if $Timer.time_left == 0:
		play_music()
		set_process(false)
func play_music():
	$Music.stream = ost
	$Music.play()
