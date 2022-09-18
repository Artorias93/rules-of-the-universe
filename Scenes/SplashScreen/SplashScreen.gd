extends Control

onready var timer = $ColorRect2/Timer
onready var anim_play1 = $ColorRect/AnimationPlayer
onready var anim_play2 = $ColorRect2/AnimationPlayer2
var check = 0


func _ready():
	get_node("/root/Audio/Effects").volume_db = log(0.3)*20
	get_node("/root/Audio/Music").volume_db = log(0.5)*20
	$GameLab.hide()
	$BankItalia.hide()
	$Sapienza.hide()
	$ColorRect.color = Color(0,0,0,255)
	timer.start(0.5)
	
func _process(delta):
	if timer.time_left == 0:
		if check == 0: anim_time(anim_play1,"Fade-Out(NB)",2.5,1)
		elif check == 1: anim_time(anim_play2,"Fade-Out(AB)",1,2)
		elif check == 2: anim_time(anim_play2,"Fade-In(BA)",2.5,3)
		elif check == 3: anim_time(anim_play2,"Fade-In",1,4)
		elif check == 4: SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
		
func anim_time(anim_play,anim,sec,ctrl):
	anim_play.play(anim)
	timer.start(sec)
	check = ctrl
		
func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect2.show()
	$GameLab.show()
	$BankItalia.show()
	$Sapienza.show()
	$ColorRect2.color = Color(255,255,255,255)
	$ColorRect2/AnimationPlayer2.play("Fade-In(BA)")

func _on_AnimationPlayer2_animation_finished(anim_name):
	if check == 2:
		$GameLab.hide()
		$BankItalia.hide()
		$Sapienza.hide()
		$OrganizationXIII.show()
		
	
