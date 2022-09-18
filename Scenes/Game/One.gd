extends Control

var d = 0
var r1 = 0
var r2 = 0
var ctrl = 0
var data = {}
var bonmalstart = 0
var pathstr = ""
var domande = null
var risp1 = null
var risp2 = null
var ind = Vector3()
var ind1 = null
var ind2 = null
var avatar = null
var bias = null
var bonmal1 = ""
var bonmal2 = ""
var info = null
var anni = ""
var mesi = ""
var score = 0
var heart = {0: 0, 1: -126, 2: -252, 3: -378, 4: -505}
var brain = {0: 0, 1: -157, 2: -315, 3: -472, 4: -630}
var money = {0: 0, 1: -162, 2: -325, 3: -487, 4: -650}
var hstop = 0
var bstop = 0
var mstop = 0
var maxd = 0
var maxr1 = 0
var maxr2 = 0
var eff = ["bonus", "malus", "bias"]
var checksc = 1
var heartpos = null
var brainpos = null
var moneypos = null
var params = null
var debt = 0
var study = 0
var stopsfx = false
var ending = {"L1": "112", "L2": "11111", "L3": "21", "L4": "1211", "L5": ["22111", "22112", "22121", "22122", "222111", "222211"], "W1": "11121", "W2": "1221", "W3": ["222121", "222221"]}
onready var audio = get_node("/root/Audio")
onready var prev_vol_eff = 0
onready var prev_vol_mus = 0

func init(params):
	restart(params)
	
func _ready():
	$Rect/ColorRect.show()
	$Rect/ColorRect.color = Color(0,0,0,255)
	$Rect/ColorRect/AnimationPlayer.play("Fade-Out")
	if audio.get_node("Music").volume_db == log(0): 
		$Music.set_pressed(true)
		prev_vol_mus = -24
	if audio.get_node("Effects").volume_db == log(0):
		$Effects.set_pressed(true)
		prev_vol_eff = log(0.5)*30
	audio.play_music("game")
	
	
# warning-ignore:unused_argument
func _process(delta):
	if heartpos.position.y > heart[int(ind[1])]:
		heartpos.move_and_collide(Vector2(0,-1)*delta*100)
		if hstop == 2: 
			heartpos.position.y = heart[int(ind[1])]
			hstop = 0
		else: hstop = 1
	elif heartpos.position.y < heart[int(ind[1])]:
		heartpos.move_and_collide(Vector2(0,1)*delta*100)
		if hstop == 1: 
			heartpos.position.y = heart[int(ind[1])]
			hstop = 0
		else: hstop = 2
	if brainpos.position.y > brain[int(ind[4])]:
		brainpos.move_and_collide(Vector2(0,-1)*delta*100)
		if bstop == 2: 
			brainpos.position.y = brain[int(ind[4])]
			bstop = 0
		else: bstop = 1
	elif brainpos.position.y < brain[int(ind[4])]:
		brainpos.move_and_collide(Vector2(0,1)*delta*100)
		if bstop == 1: 
			brainpos.position.y = brain[int(ind[4])]
			bstop = 0
		else: bstop = 2
	if moneypos.position.y > money[int(ind[7])]:
		moneypos.move_and_collide(Vector2(0,-1)*delta*100)
		if mstop == 2: 
			moneypos.position.y = money[int(ind[7])]
			mstop = 0
		else: mstop = 1
	elif moneypos.position.y < money[int(ind[7])]:
		moneypos.move_and_collide(Vector2(0,1)*delta*100)
		if mstop == 1: 
			moneypos.position.y = money[int(ind[7])]
			mstop = 0
		else: mstop = 2
	if $TimerText.time_left == 0 and d < maxd:
		d = write_text($Domanda)
	if d == maxd:
		if checksc == 1:
			r1 = write_text($Risposta/Risposta)
			if r1 == maxr1:
				$Rect/ColorRect.hide()
				set_process(false)
		else:
			r1 = write_text($Risposta1/Risposta1)
			r2 = write_text($Risposta2/Risposta2)
			if max(r1, r2) == max(maxr1, maxr2):
				$Rect/ColorRect.hide()
				set_process(false)
				
func restart(params):
	stopsfx = false
	$Rect/ColorRect.show()
	$TimerText.start(0.01)
	heartpos = $BoxIndicatori/HeartEmpty/KBH
	brainpos = $BoxIndicatori/BrainEmpty/KBB
	moneypos = $BoxIndicatori/MoneyEmpty/KBM
	ctrl = params[0]
	data = params[1]
	pathstr = params[2]
	checksc = params[3]
	domande = data["Domande"][pathstr]
	risp1 = data["Risp1"][pathstr]
	risp2 = data["Risp2"][pathstr]
	ind = data["Ind"][pathstr]
	ind1 = data["Ind1"][pathstr]
	ind2 = data["Ind2"][pathstr]
	avatar = data["Avatar"][pathstr]
	info = data["Info"][pathstr]
	if not ending.has(pathstr):
		bonmal1 = data["BonMal1"][pathstr]
		bonmal2 = data["BonMal2"][pathstr]
		anni = str(data["Anni"][pathstr])
		mesi = str(data["Mesi"][pathstr])
		bias = data["BIAS"][pathstr]
	$BoxAvatar.set_texture(load("res://Scenes/Game/Avatar/" + avatar))
	d = 0
	$Domanda.visible_characters = 0
	$Domanda.text = domande
	maxd = $Domanda.get_total_character_count()
	if checksc == 1:
		if pathstr != "00": $Risposta.step = 0
		r1 = 0
		$Risposta/Risposta.visible_characters = 0
		$Risposta/Risposta.text = risp1
		maxr1 = $Risposta/Risposta.get_total_character_count()
	else:
		if pathstr != "00": $Risposta1.step = 0
		if pathstr != "00": $Risposta2.step = 0
		r1 = 0
		r2 = 0
		$Risposta1/Risposta1.visible_characters = 0
		$Risposta2/Risposta2.visible_characters = 0
		$Risposta1/Risposta1.text = risp1
		$Risposta2/Risposta2.text = risp2
		maxr1 = $Risposta1/Risposta1.get_total_character_count()
		maxr2 = $Risposta2/Risposta2.get_total_character_count()
	if bonmal1 == "Debito" or bonmal2 == "Debito": 
		debt += 1
		$BoxIndicatori/MoneyEmpty/MMalus.show()
		if "malus" in eff:
			audio.play_effects("malus")
			eff.erase("malus")
	else: $BoxIndicatori/MoneyEmpty/MMalus.hide()
	if bonmal1 == "Studio" or bonmal2 == "Studio":
		study += 1
		if "bonus" in eff:
			audio.play_effects("bonus")
			eff.erase("bonus")
	if bonmal1 != "":
		$BoxBonus/Active1.set_texture(load("res://Scenes/Game/BonusMalus/" + bonmal1 + ".png"))
		$BoxBonus/Active1.show()
	else: 
		$BoxBonus/Active1.hide()
	if bonmal2 != "":
		$BoxBonus/Active2.set_texture(load("res://Scenes/Game/BonusMalus/" + bonmal2 + ".png"))
		$BoxBonus/Active2.show()
	else:
		$BoxBonus/Active2.hide()
	if bias == "Gregge":
		if "bias" in eff:
			audio.play_effects("bias")
			eff.erase("bias")
	if anni != "": $BoxBonus/Anni.text = anni + " Anni"
	if mesi != "": $BoxBonus/Mesi.text = mesi + " Mesi"
	if info != "": $Domanda/Info.show()
	else: $Domanda/Info.hide()
	if ending.has(pathstr):
		if bonmal1 == "Debito" or bonmal2 == "Debito": score += -500
		elif bonmal1 == "Studio" or bonmal2 == "Studio": score += 500
		if bias == "Gregge": score -= 2000
		score += (int(ind[1]) + int(ind[4]) + int(ind[7]))/3 * 100 + int(anni) * 1000 + int(mesi) * 250
	set_process(true)


func write_text(obj):
	obj.visible_characters += 1
	$TimerText.start(0.01)
	if obj.visible_characters == obj.get_total_character_count()+1:
		obj.visible_characters -= 1
	return obj.visible_characters
	


func _on_NewGame_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			ctrl = 2
			$Rect/ColorRect.show()
			$Rect/ColorRect/AnimationPlayer.play("Fade-In")
			
			
func _on_Menu_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			ctrl = 3
			$Rect/ColorRect.show()
			$Rect/ColorRect/AnimationPlayer.play("Fade-In")


func _on_AnimationPlayer_animation_finished(anim_name):
	if ctrl == 2:
		SceneManager.goto_scene("res://Scenes/SexChoise/SexChoise.tscn")
		audio.play_music("ost")
		audio.stop_sfx()
	if ctrl == 3:
		SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
		audio.play_music("ost")
		audio.stop_sfx()


func _on_Bonus1_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bonmalstart = 1


func _on_Bonus2_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bonmalstart = 1


func _on_Bonus3_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bonmalstart = 1


func _on_Bonus4_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bonmalstart = 1


func _on_Indietro2_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bonmalstart = 2


func _on_Effects_toggled(button_pressed):
	if button_pressed:
		prev_vol_eff = get_node("/root/Audio/Effects").volume_db
		get_node("/root/Audio/Effects").volume_db = log(0)
	else: get_node("/root/Audio/Effects").volume_db = prev_vol_eff


func _on_Music_toggled(button_pressed):
	if button_pressed: 
		prev_vol_mus = get_node("/root/Audio/Music").volume_db
		get_node("/root/Audio/Music").volume_db = log(0)
	else: get_node("/root/Audio/Music").volume_db = prev_vol_mus
