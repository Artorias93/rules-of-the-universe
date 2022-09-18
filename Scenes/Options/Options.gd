extends Control


var posmus = 0
var poseff = 0
onready var sat = $Sat/Sat
onready var audio = get_node("/root/Audio")


func _ready():
	$ColorRect.show()
	$ColorRect.color = Color(0,0,0,255)
	$ColorRect/AnimationPlayer.play("Fade-Out")
	$VolumeEff/VolumeEff.step = 0.0001
	$VolumeMus/VolumeMus.step = 0.0001
	if get_node("/root/Audio/Music").volume_db == log(0): $VolumeMus/VolumeMus.value = 0
	else: $VolumeMus/VolumeMus.value = exp(get_node("/root/Audio/Music").volume_db/20)
	if get_node("/root/Audio/Effects").volume_db == log(0): $VolumeEff/VolumeEff.value = 0
	else: $VolumeEff/VolumeEff.value = exp(get_node("/root/Audio/Effects").volume_db/20)
	$VolumeEff/VolumeEff.max_value = 1
	$VolumeMus/VolumeMus.max_value = 1
	$Lingua/Lingue.add_item("Italiano", 0)
	$Lingua/Lingue.add_separator()
	$Lingua/Lingue.add_item("Inglese", 1)
	$Lingua/Lingue.add_item("Spagnolo", 2)
	$Lingua/Lingue.add_item("Francese", 3)
	$Lingua/Lingue.add_item("Tedesco", 4)
	$Lingua/Lingue.add_item("Portoghese", 5)
	$Lingua/Lingue.add_item("Cinese", 6)
	$Lingua/Lingue.add_item("Giapponese", 7)
	$Lingua/Lingue.add_item("Russo", 8)
	$Lingua/Lingue.set_item_disabled(2, true)
	$Lingua/Lingue.set_item_disabled(3, true)
	$Lingua/Lingue.set_item_disabled(4, true)
	$Lingua/Lingue.set_item_disabled(5, true)
	$Lingua/Lingue.set_item_disabled(6, true)
	$Lingua/Lingue.set_item_disabled(7, true)
	$Lingua/Lingue.set_item_disabled(8, true)
	$Lingua/Lingue.set_item_disabled(9, true)
	
	
func _process(delta):
	sat.set_offset(sat.get_offset() + 50 * -delta)
	if $VolumeMus/VolumeMus.value > 0: $MusEff/Musica.pressed = true
	else: 
		$MusEff/Musica.pressed = false
	if $VolumeEff/VolumeEff.value > 0: $MusEff/Effetti.pressed = true
	else: $MusEff/Effetti.pressed = false
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if $Indietro.click == 1: SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
	else: $ColorRect.hide()


func _on_Musica_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if $MusEff/Musica.pressed: 
				posmus = $VolumeMus/VolumeMus.value
				$VolumeMus/VolumeMus.value = 0
			else:
				$VolumeMus/VolumeMus.value = posmus


func _on_Effetti_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if $MusEff/Effetti.pressed: 
				poseff = $VolumeEff/VolumeEff.value
				$VolumeEff/VolumeEff.value = 0
			else: 
				$VolumeEff/VolumeEff.value = poseff


func _on_VolumeEff_value_changed(value):
	audio.get_node("Effects").volume_db = log($VolumeEff/VolumeEff.value) * 20


func _on_VolumeMus_value_changed(value):
	audio.get_node("Music").volume_db = log($VolumeMus/VolumeMus.value) * 20
