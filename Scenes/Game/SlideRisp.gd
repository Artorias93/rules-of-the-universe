extends KinematicBody2D

var save = []
var stopdrag
var params = {}
var speed = Vector2()
var check = false
var click = 0
var ctrllev = 0
var go = false
var delt = 0
var step = 0
var key = 0
var ctrl = false
var r = 0
var s = 0
var a = 0
var b = 0
var all = []
var maxall = []
var maxres = 0
var bon1 = 0
var dbon1 = 0
var bon2 = 0
var dbon2 = 0
var back2 = 0
var bonmal = 0
var highscpath = ""
#var stopsfx = false
onready var bonmalref = get_node("../Feedback/Feedback/BonMal")
onready var back2ref = get_node("../Feedback/Feedback/Back2/Indietro2")
onready var dbon2ref = get_node("../Feedback/Feedback/Bon2/Descr2")
onready var bon2ref = get_node("../Feedback/Feedback/Bon2")
onready var dbon1ref = get_node("../Feedback/Feedback/Bon1/Descr1")
onready var bon1ref = get_node("../Feedback/Feedback/Bon1")
onready var resref = get_node("../Feedback/Feedback/Result")
onready var scoreref = get_node("../Feedback/Feedback/Score")
onready var ageref = get_node("../Feedback/Feedback/Age")
onready var biasref = get_node("../Feedback/Feedback/Bias")
onready var feedback = get_node("../Feedback/Feedback")
onready var ending = get_parent().ending
onready var levsx = get_node("../Container/LeverSx")
onready var levdx = get_node("../Container/LeverDx")

func _ready():
	$SideStand.paused = true
	$SideStand.start()
	$CenterStand.start(3)
	if OS.get_name() == "Windows": highscpath = "res://Scenes/Game/HighScore.json"
	elif OS.get_name() == "Android": highscpath = "user://HighScore.json"


func _process(delta):
	if get_parent().checksc == 1:
		if step == 0:
			if position.y > 1332:
				move_and_collide(Vector2(0,-15)*delta*100)
				return
			else:
				move_and_collide(Vector2(0,0)*delta*100)
				position.y = 1332
				step = 1
		speed = Vector2()
		delt = delta
		if get_parent().bonmalstart == 1:
			get_tree().call_group("Int", "hide")
			get_tree().call_group("BonusMalus", "show")
			get_node("../Rect/ColorRect").show()
			if get_node("../Feedback").position.x < 0:
				get_node("../Feedback").move_and_collide(Vector2(15, 0)*200*delt)
			else:
				setbonmal(get_node("../BoxBonus/Active1"), "res://Scenes/Game/BonusMalus/Debito.png", get_node("../Feedback/Feedback/Bon1/Active1"), get_node("../Feedback/Feedback/Bon1/TitleBon1"), get_node("../Feedback/Feedback/Bon1/Descr1"), "DEBITO", "Sei indebitata fino al collo! Devi ripagare i debiti: -5% Denaro Max ogni turno. Turni restanti: " + str(5 - get_parent().debt) + ".")
				setbonmal(get_node("../BoxBonus/Active1"), "res://Scenes/Game/BonusMalus/Studio.png", get_node("../Feedback/Feedback/Bon1/Active1"), get_node("../Feedback/Feedback/Bon1/TitleBon1"), get_node("../Feedback/Feedback/Bon1/Descr1"), "STUDIO", "Le domande a tema 'Università' potenziano gli effetti positivi del 5%. Turni restanti: " + str(3 - get_parent().study) + ".")
				setbonmal(get_node("../BoxBonus/Active2"), "res://Scenes/Game/BonusMalus/Studio.png", get_node("../Feedback/Feedback/Bon2/Active2"), get_node("../Feedback/Feedback/Bon2/TitleBon2"), get_node("../Feedback/Feedback/Bon2/Descr2"), "STUDIO", "Le domande a tema 'Università' potenziano gli effetti positivi del 5%. Turni restanti: " + str(3 - get_parent().study) + ".")
				get_node("../Feedback").position.x = 0
				var maxbonmal = get_node("../Feedback/Feedback/BonMal").get_total_character_count()
				var maxbon1 = get_node("../Feedback/Feedback/Bon1/TitleBon1").get_total_character_count()
				var maxdbon1 = get_node("../Feedback/Feedback/Bon1/Descr1").get_total_character_count()
				var maxbon2 = get_node("../Feedback/Feedback/Bon2/TitleBon2").get_total_character_count()
				var maxdbon2 = get_node("../Feedback/Feedback/Bon2/Descr2").get_total_character_count()
				var maxback2 = get_node("../Feedback/Feedback/Back2/Indietro2").get_total_character_count()
				var maxall = [maxbon1, maxdbon1, maxback2, maxbonmal]
				maxall.sort()
				var all = [bon1, dbon1, back2, bonmal]
				all.sort()
				if get_node("../BoxBonus/Active1").texture == null:
					if bonmal < maxbonmal:
						back2 = get_parent().write_text(back2ref)
						bonmal = get_parent().write_text(bonmalref)
					else: get_node("../Rect/ColorRect").hide()
				elif bonmal > 0:
					if max(bon1, dbon1) < max(maxbon1, maxdbon1):
						back2 = get_parent().write_text(back2ref)
						bonmal = get_parent().write_text(bonmalref)
						bon1 = get_parent().write_text(bon1ref)
						dbon1 = get_parent().write_text(dbon1ref)
					elif max(bon2, dbon2) < max(maxbon2, maxdbon2):
						bon2 = get_parent().write_text(dbon2ref)
						dbon2 = get_parent().write_text(dbon2ref)
					else: get_node("../Rect/ColorRect").hide()
				elif bonmal == 0:
					if all[3] < maxall[3]:
						back2 = get_parent().write_text(back2ref)
						bonmal = get_parent().write_text(bonmalref)
						bon1 = get_parent().write_text(bon1ref)
						dbon1 = get_parent().write_text(dbon1ref)
				else: get_node("../Rect/ColorRect").hide()
		elif get_parent().bonmalstart == 2:
			get_node("../Rect/ColorRect").show()
			if get_node("../Feedback").position.x > -1040:
				get_node("../Feedback").move_and_collide(Vector2(-15, 0)*200*delt)
			else:
				get_node("../Feedback").position.x = -1040
				get_node("../Rect/ColorRect").hide()
				get_tree().call_group("BonusMalus", "hide")
				get_parent().bonmalstart = 0

		if position.x >= 440:
			if ctrllev == 1:
				hideind()
				levsx.playing = false
				levsx.frame = 0
			levmaj(levsx, 15)
		if position.x <= 640:
			if ctrllev == 2:
				hideind()
				levdx.playing = false
				levdx.frame = 0
			levmin(levdx, 15)
		if get_parent().ctrl == 1:
			tutorial(delta)
		if $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider: 
				if "Dx" in collider.name:
					ctrllev = 2
					indicators(get_parent().ind2)
					levdx.playing = true
					levmaj(levdx, 105)
				elif "Sx" in collider.name:
					ctrllev = 1
					indicators(get_parent().ind1)
					levsx.playing = true
					levmin(levsx, -75)
		if click == 0 and get_parent().ctrl == 0:
			if position.x < 530:
				speed = Vector2(5,0)
			elif position.x > 550:
				speed = Vector2(-5,0)
		if position.x <= 300:
			speed = Vector2(-20,0)
		if position.x >= 780:
			speed = Vector2(20,0)
		
		move_and_collide(speed*delta*100)
	
		if position.x <= -356 or position.x >= 1436:
			if get_parent().stopsfx == false:
				get_node("../").audio.play_effects("slide")
				get_parent().stopsfx = true
			levsx.playing = false
			levsx.frame = 0
			levdx.playing = false
			levdx.frame = 0
			if get_parent().pathstr == "00":
				reload(0, get_parent().data, "0", 2)
			else:
				if ending.has(get_parent().pathstr):
					if ctrl == false:
						get_tree().call_group("Final", "show")
						get_tree().call_group("Int", "hide")
						get_node("../Rect/ColorRect").show()
						if  get_node("../Feedback").position.x < 0:
							get_node("../Feedback").move_and_collide(Vector2(15,0)*200*delta)
							return
						else:
							get_node("../Feedback").position.x = 0
						if get_parent().pathstr in ["L2", "L3", "L5"]:
							indfeedback("Ind1", Vector2(540, 380), "res://Scenes/Game/Indicatori/MoneyEmpty.png", "res://Scenes/Game/Indicatori/MoneyFail.png")
						if get_parent().pathstr == "L1":
							indfeedback("Ind1", Vector2(540, 380), "res://Scenes/Game/Indicatori/HeartEmpty.png", "res://Scenes/Game/Indicatori/HeartFail.png")
						if get_parent().pathstr == "L4":
							indfeedback("Ind1", Vector2(360, 380), "res://Scenes/Game/Indicatori/HeartEmpty.png", "res://Scenes/Game/Indicatori/HeartFail.png")
							indfeedback("Ind2", Vector2(720, 380), "res://Scenes/Game/Indicatori/BrainEmpty.png", "res://Scenes/Game/Indicatori/BrainFail.png")
						if get_parent().pathstr in ["W1", "W2", "W3"]:
							feedback.get_node("Result").text = "HAI VINTO!"
							get_node("../BoxIndicatori/HeartEmpty").position = Vector2(230, 380)
							get_node("../BoxIndicatori/HeartEmpty").z_index = 1
							get_node("../BoxIndicatori/BrainEmpty").position = Vector2(540, 380)
							get_node("../BoxIndicatori/BrainEmpty").z_index = 1
							get_node("../BoxIndicatori/MoneyEmpty").position = Vector2(850, 380)
							get_node("../BoxIndicatori/MoneyEmpty").z_index = 1
						ctrl = true
						if feedback.get_node("Result").text == "HAI VINTO!": get_node("../").audio.play_effects("win")
						else: get_node("../").audio.play_effects("lose")
						feedback.get_node("Score").text = "PUNTEGGIO: " + str(get_parent().score)
						feedback.get_node("Age").text = "ETÀ RAGGIUNTA:\n" + get_parent().anni + " Anni e " + get_parent().mesi + " Mesi"
						if get_parent().bias == "Gregge": 
							feedback.get_node("Bias").rect_size.y = 660
							feedback.get_node("Bias").rect_pivot_offset.y = 330
							feedback.get_node("Bias").get("custom_fonts/font").set_size(52)
							feedback.get_node("Bias").text = "BIAS: EFFETTO GREGGE\nÈ la tendenza che molti hanno\na seguire il comportamento\ndella maggioranza quando si tratta\ndi prendere decisioni: spesso le decisioni prese così portano ad insoddisfazione rispetto all’aver preso isolatamente le decisioni."
						else:
							feedback.get_node("Bias").get("custom_fonts/font").set_size(65)
							feedback.get_node("Bias").rect_size.y = 140
							feedback.get_node("Bias").rect_pivot_offset.y = 70
							feedback.get_node("Bias").text = "NESSUN BIAS INCONTRATO"
							get_parent().bias = "-"
						maxres = feedback.get_node("Result").get_total_character_count()
						var maxscore = feedback.get_node("Score").get_total_character_count()
						var maxage = feedback.get_node("Age").get_total_character_count()
						var maxbias = feedback.get_node("Bias").get_total_character_count()
						maxall = [maxres, maxscore, maxage, maxbias]
						maxall.sort()
					all = [r, s, a, b]
					all.sort()
					if all[3] < maxall[3]:
						if r == maxres:
							feedback.get_node("Ind1").show()
							feedback.get_node("Ind2").show()
							feedback.get_node("Ind1").play()
							feedback.get_node("Ind2").play()
						r = get_parent().write_text(resref)
						s = get_parent().write_text(scoreref)
						a = get_parent().write_text(ageref)
						b = get_parent().write_text(biasref)
					else: 
						var file = File.new()
						file.open(highscpath,File.READ)
						if file.file_exists(highscpath):
							save = parse_json(file.get_as_text())
						var update = {"Punteggio": str(get_parent().score), "Anni": get_parent().anni, "Mesi": get_parent().mesi, "BIAS": get_parent().bias}
						var insert = true
						for i in save:
							i = i.values()
							var upd = update.values()
							i.sort()
							upd.sort()
							if i == upd:
								insert = false
						if insert == true:
							save.append(update)
						else:
							file.close()
							set_process(false)
						file.close()
						file = File.new()
						save.sort_custom(self,"customsort")
						file.open(highscpath,File.WRITE)
						file.store_line(to_json(save))
						file.close()
						
						get_node("../Rect/ColorRect").hide()
						set_process(false)
					return
				for i in ending.keys(): 
					if ending[i] is String:
						if get_parent().pathstr + "1" == ending[i]:
							reload(0, get_parent().data, i, 1)
							break
					elif ending[i] is Array:
						for j in ending[i]:
							if get_parent().pathstr + "1" == j:
								reload(0, get_parent().data, i, 1)
								break
				
func reload(zero, one, two, three):
	
	stopdrag = InputEventMouseButton.new()
	stopdrag.set_button_index(1)
	stopdrag.set_pressed(false)
	Input.parse_input_event(stopdrag)
	
	params[0] = zero
	params[1] = one
	params[2] = two
	params[3] = three
	if three == 2:
		get_node("../Risposta1").position = Vector2(340,1800)
		get_node("../Risposta2").position = Vector2(740, 1800)
		get_node("../BetweenRisp").position = Vector2(540, 1800)
		position = Vector2(540, 2500)
	else:
		position = Vector2(540, 1800)
	hideind()
	get_parent().restart(params)

func indfeedback(ind, pos, frame1, frame2):
	feedback.get_node("Result").text = "HAI PERSO!"
	feedback.get_node(ind).global_position = pos
	feedback.get_node(ind).frames.add_frame("Fail", load(frame1), 0)
	feedback.get_node(ind).frames.add_frame("Fail", load(frame2), 1)

func tutorial(delta):
	if $CenterStand.time_left == 0:
		go = true
	if go == true:
		$Risposta/Slide.show()
		if position.x > 456 and check == false:
			$Risposta/Slide.set_texture(load("res://Utility/SlideSx.png"))
			speed = Vector2(-1,0)
		elif position.x < 624 and check == true:
			$Risposta/Slide.set_texture(load("res://Utility/SlideDx.png"))
			speed = Vector2(1,0)
		else:
			speed = Vector2(0,0)
			if $SideStand.time_left == 1:
				$SideStand.paused = false
			elif $SideStand.time_left == 0:
				check = not check
				position.x = 540
				$Risposta/Slide.hide()
				$SideStand.paused = true
				$SideStand.start()
				go = false
				$CenterStand.start(1)
	else: 
		speed = Vector2(0,0)
	move_and_collide(speed*100*delta)


func _on_Risposta_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			$Risposta/Slide.hide()
			get_parent().ctrl = 0
			click = 1
		if event.pressed == false:
			click = 0
	if event is InputEventScreenDrag:
		if event.speed.x > 0: $RayCast2D.cast_to.x = 350
		else: $RayCast2D.cast_to.x = -350
		var speed = Vector2(event.speed.x,0)
		move_and_collide(speed*2*delt)
		
func indicators(index):
	if index[1] == "1": 
		get_node("../BoxIndicatori/HeartEmpty/HPoint").scale = Vector2(1.5, 1.5)
		get_node("../BoxIndicatori/HeartEmpty/HPoint").show()
	elif index[1] == "2":
		get_node("../BoxIndicatori/HeartEmpty/HPoint").scale = Vector2(2.5, 2.5)
		get_node("../BoxIndicatori/HeartEmpty/HPoint").show()
	if index[4] == "1": 
		get_node("../BoxIndicatori/BrainEmpty/BPoint").scale = Vector2(1.5, 1.5)
		get_node("../BoxIndicatori/BrainEmpty/BPoint").show()
	elif index[4] == "2":
		get_node("../BoxIndicatori/BrainEmpty/BPoint").scale = Vector2(2.5, 2.5)
		get_node("../BoxIndicatori/BrainEmpty/BPoint").show()
	if index[7] == "1": 
		get_node("../BoxIndicatori/MoneyEmpty/MPoint").scale = Vector2(1.5, 1.5)
		get_node("../BoxIndicatori/MoneyEmpty/MPoint").show()
	elif index[7] == "2":
		get_node("../BoxIndicatori/MoneyEmpty/MPoint").scale = Vector2(2.5, 2.5)
		get_node("../BoxIndicatori/MoneyEmpty/MPoint").show()


func setbonmal(ifpath1, ifpath2, dpath1, dpath2, dpath3, text1, text2):
	if ifpath1.texture != null:
		if ifpath1.texture.resource_path == ifpath2:
			dpath1.set_texture(load(ifpath2))
			dpath2.text = text1
			dpath3.text = text2
	else:
		dpath1.set_texture(null)
		dpath2.text = ""
		dpath3.text = ""
	
func hideind():
	get_node("../BoxIndicatori/HeartEmpty/HPoint").hide()
	get_node("../BoxIndicatori/BrainEmpty/BPoint").hide()
	get_node("../BoxIndicatori/MoneyEmpty/MPoint").hide()


func levmaj(lev, cap):
	lev.rotation_degrees += 5
	if lev.rotation_degrees >= cap: 
		lev.rotation_degrees = cap
		
func levmin(lev, cap):
	lev.rotation_degrees -= 5
	if lev.rotation_degrees <= cap: 
		lev.rotation_degrees = cap

func customsort(a,b):
	if a["Punteggio"] > b["Punteggio"]:
		return true
	elif a["Punteggio"] == b["Punteggio"] and a["Anni"] > b["Anni"]:
		return true
	elif a["Punteggio"] == b["Punteggio"] and a["Anni"] == b["Anni"] and a["Mesi"] > b["Mesi"]:
		return true
	elif a["Punteggio"] == b["Punteggio"] and a["Anni"] == b["Anni"] and a["Mesi"] == b["Mesi"] and a["BIAS"] == "-":
		return true
	else:
		return false
