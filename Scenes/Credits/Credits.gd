extends Control


var cred1 = 0
var cred2 = 0
onready var ufo = $Ufo/Ufo

func _ready():
	set_process(false)
	$ColorRect.show()
	$ColorRect.color = Color(0,0,0,255)
	$ColorRect/AnimationPlayer.play("Fade-Out")
	$LogoTeam.play()
	$LogoTeam.frames.remove_frame("Play", 0)
	
	
func _process(delta):
	ufo.set_offset(ufo.get_offset() + 50 * -delta)
	if max(cred1, cred2) < max($Team.get_total_character_count(),$Thanks.get_total_character_count()):
		cred1 = write_text(get_node("Team"))
		cred2 = write_text(get_node("Thanks"))
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	set_process(true)
	if $Indietro.click == 1: SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
	else: $ColorRect.hide()
	
func write_text(obj):
	obj.visible_characters += 1
	$Timer.start(0.01)
	if obj.visible_characters == obj.get_total_character_count()+1:
		obj.visible_characters -= 1
	return obj.visible_characters
