extends KinematicBody2D

var stopdrag = null
var params = {}
var choice = 0
var speed = Vector2()
var check = 0
var delt = 0
var step = 0
var end = false
var infostart = 0
var ints = 0
var intd1 = 0
var intc = 0
var intd2 = 0
var back = 0
var bon1 = 0
var dbon1 = 0
var bon2 = 0
var dbon2 = 0
var back2 = 0
var bonmal = 0
onready var bonmalref = get_node("../Feedback/Feedback/BonMal")
onready var back2ref = get_node("../Feedback/Feedback/Back2/Indietro2")
onready var dbon2ref = get_node("../Feedback/Feedback/Bon2/Descr2")
onready var bon2ref = get_node("../Feedback/Feedback/Bon2")
onready var dbon1ref = get_node("../Feedback/Feedback/Bon1/Descr1")
onready var bon1ref = get_node("../Feedback/Feedback/Bon1")
onready var backref = get_node("../Feedback/Feedback/Back/Indietro")
onready var intsref = get_node("../Feedback/Feedback/IntSem")
onready var intd1ref = get_node("../Feedback/Feedback/IntSem/Descr1")
onready var intcref = get_node("../Feedback/Feedback/IntCom")
onready var intd2ref = get_node("../Feedback/Feedback/IntCom/Descr2")
onready var ending = get_parent().ending
onready var levsx = get_node("../Container/LeverSx")
onready var levdx = get_node("../Container/LeverDx")
onready var labsx = get_node("../Risposta1")
onready var labdx = get_node("../Risposta2")

func _ready():
	pass
	
func _process(delta):
	if get_parent().checksc == 2:
		if step == 0:
			if position.y > 1332:
				labsx.move_and_collide(Vector2(0,-10)*delta*100)
				labdx.move_and_collide(Vector2(0,-10)*delta*100)
				get_node("../BetweenRisp").position.y = 1332
				return
			else:
				get_node("../BetweenRisp").position.y = 1332
				labsx.move_and_collide(Vector2(0,0)*delta*100)
				labdx.move_and_collide(Vector2(0,0)*delta*100)
				labsx.position.y = 1332
				labdx.position.y = 1332
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
				
		if infostart == 1:
			get_tree().call_group("BonusMalus", "hide")
			get_tree().call_group("Int", "show")
			get_node("../Rect/ColorRect").show()
			if get_node("../Feedback").position.x < 0:
				get_node("../Feedback").move_and_collide(Vector2(15, 0)*200*delt)
			else:
				get_node("../Feedback").position.x = 0
				var maxsemp = get_node("../Feedback/Feedback/IntSem").get_total_character_count()
				var maxdescr1 = get_node("../Feedback/Feedback/IntSem/Descr1").get_total_character_count()
				var maxcomp = get_node("../Feedback/Feedback/IntCom").get_total_character_count()
				var maxdescr2 = get_node("../Feedback/Feedback/IntCom/Descr2").get_total_character_count()
				var maxback = get_node("../Feedback/Feedback/Back/Indietro").get_total_character_count()
				var maxall2 = [maxsemp, maxdescr1, maxcomp, maxdescr2, maxback]
				maxall2.sort()
				var all2 = [ints, intd1, intc, intd2, back]
				all2.sort()
				if all2[4] < maxall2[4]:
					ints = get_parent().write_text(intsref)
					intd1 = get_parent().write_text(intd1ref)
					intc = get_parent().write_text(intcref)
					intd2 = get_parent().write_text(intd2ref)
					back = get_parent().write_text(backref)
				else: get_node("../Rect/ColorRect").hide()
		elif infostart == 2:
			get_node("../Rect/ColorRect").show()
			if get_node("../Feedback").position.x > -1040:
				get_node("../Feedback").move_and_collide(Vector2(-15, 0)*200*delt)
			else:
				get_node("../Feedback").position.x = -1040
				get_node("../Rect/ColorRect").hide()
				get_tree().call_group("Int", "hide")
				infostart = 0
		if labsx.position.x >= 260:
			levsx.playing = false
			levsx.frame = 0
			levmaj(levsx, 15)
		if labdx.position.x <= 820:
			levdx.playing = false
			levdx.frame = 0
			levmin(levdx, 15)
		if labsx.position.x >= 260 and labdx.position.x <= 820: hideind()
		if $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider: 
				if "Dx" in collider.name:
					indicators(get_parent().ind2)
					levdx.playing = true
					levmaj(levdx, 105)
				elif "Sx" in collider.name:
					indicators(get_parent().ind1)
					levsx.playing = true
					levmin(levsx, -75)
		if check == 1 and labsx.position.x < 340:
			speed = Vector2(5,0)
		if check == 2 and labdx.position.x > 740:
			speed = Vector2(-5,0)
		if labsx.position.x <= 130:
			choice = 1
			speed = Vector2(-20,0)
			get_node("../").audio.play_effects("slide")
			labdx.move_and_collide(Vector2(0, 10)*delta*100)
		if labdx.position.x >= 950:
			choice = 2
			speed = Vector2(20,0)
			get_node("../").audio.play_effects("slide")
			labsx.move_and_collide(Vector2(0, 10)*delta*100)
		if position.y >= 1500:
			levsx.playing = false
			levsx.frame = 0
			levdx.playing = false
			levdx.frame = 0
			speed = Vector2()
			if get_parent().pathstr == "0":
				reload(0, get_parent().data, str(choice), 2)
			else:
				for i in ending.keys():
					if ending[i] is String:
						if get_parent().pathstr + str(choice) == ending[i]:
							reload(0, get_parent().data, i, 1)
							end = true
							break
					elif ending[i] is Array:
						for j in ending[i]:
							if get_parent().pathstr + str(choice) == j:
								reload(0, get_parent().data, i, 1)
								end = true
								break
				if end == false:
					if get_parent().data["Risp2"][get_parent().pathstr + str(choice)] != "":
						reload(0, get_parent().data, get_parent().pathstr + str(choice), 2)
					else:
						reload(0, get_parent().data, get_parent().pathstr + str(choice), 1)
		move_and_collide(speed*delta*100)


func reload(zero, one, two, three):
	
	stopdrag = InputEventMouseButton.new()
	stopdrag.set_button_index(1)
	stopdrag.set_pressed(false)
	Input.parse_input_event(stopdrag)
	
	params[0] = zero
	params[1] = one
	params[2] = two
	params[3] = three
	if three == 1:
		labsx.position = Vector2(1260,1800)
		labdx.position = Vector2(1660,1800)
		get_node("../BetweenRisp").position = Vector2(1460, 1800)
		get_node("../Risposta").position = Vector2(540, 1800)
	else:
		labsx.position = Vector2(340,1800)
		labdx.position = Vector2(740, 1800)
		get_node("../BetweenRisp").position = Vector2(540, 1800)
	hideind()
	get_parent().restart(params)


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

	
func hideind():
	get_node("../BoxIndicatori/HeartEmpty/HPoint").hide()
	get_node("../BoxIndicatori/BrainEmpty/BPoint").hide()
	get_node("../BoxIndicatori/MoneyEmpty/MPoint").hide()

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

func levmaj(lev, cap):
	lev.rotation_degrees += 5
	if lev.rotation_degrees >= cap: 
		lev.rotation_degrees = cap
		
func levmin(lev, cap):
	lev.rotation_degrees -= 5
	if lev.rotation_degrees <= cap: 
		lev.rotation_degrees = cap


func _on_Risposta1_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			check = 0
		if event.pressed == false: 
			check = 1
	if event is InputEventScreenDrag:
		if event.speed.x > 0: $RayCast2D.cast_to.x = 170
		else: $RayCast2D.cast_to.x = -170
		var speed = Vector2(event.speed.x,0)
		move_and_collide(speed*2*delt)



func _on_Risposta2_gui_input(event):
	
	if event is InputEventScreenTouch:
		if event.pressed:
			check = 0
		if event.pressed == false: 
			check = 2
	if event is InputEventScreenDrag:
		if event.speed.x > 0: $RayCast2D.cast_to.x = 170
		else: $RayCast2D.cast_to.x = -170
		var speed = Vector2(event.speed.x,0)
		move_and_collide(speed*2*delt)


func _on_Info_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			infostart = 1


func _on_Indietro_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			infostart = 2
