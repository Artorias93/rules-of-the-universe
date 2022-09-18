extends Control


var data = []
var index = -1
var file = File.new()
var path = ""
var elem = 0
var clas1 = 0
var clas2 = 0
var clas3 = 0


func _ready():
	set_process(false)
	if OS.get_name() == "Windows": path = "res://Scenes/Game/HighScore.json"
	elif OS.get_name() == "Android": path = "user://HighScore.json"
	$Classifica.play()
	$Roof.play()
	$ColorRect.show()
	$ColorRect.color = Color(0,0,0,255)
	$ColorRect/AnimationPlayer.play("Fade-Out")
	file.open(path, File.READ)
	data = parse_json(file.get_as_text())
	elem = data.size()
	for i in $Griglia.get_children():
		set_label(i.name)
		index += 1
	$Timer.start(0.01)
	
		
func _process(delta):
	for i in $Griglia.get_children():
		if max(clas1,max(clas2,clas3)) < 250:
			clas1 = write_text(i.name + "/Score")
			clas1 = write_text(i.name + "/Age")
			clas1 = write_text(i.name + "/Bias")
	
	
func write_text(obj):
	if "Etichette".is_subsequence_of(obj): return 0
	obj = get_node("Griglia/" + obj)
	obj.visible_characters += 1
	$Timer.start(0.01)
	if obj.visible_characters == obj.get_total_character_count()+1:
		obj.visible_characters -= 1
	return obj.visible_characters
	
	
func set_label(vgrid):
	if vgrid == "Etichette": return
	if  index < elem: 
		get_node("Griglia/" + vgrid + "/Score").text = data[index]["Punteggio"].insert(2, ".")
		get_node("Griglia/" + vgrid + "/Age").text = data[index]["Anni"] + "." + data[index]["Mesi"]
		get_node("Griglia/" + vgrid + "/Bias").text = data[index]["BIAS"]
	else:
		get_node("Griglia/" + vgrid + "/Score").text = "-"
		get_node("Griglia/" + vgrid + "/Age").text = "-"
		get_node("Griglia/" + vgrid + "/Bias").text = "-"
	get_node("Griglia/" + vgrid + "/Score").visible_characters = 0
	get_node("Griglia/" + vgrid + "/Age").visible_characters = 0
	get_node("Griglia/" + vgrid + "/Bias").visible_characters = 0
	return
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	set_process(true)
	if $Indietro.click == 1: SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
	else: $ColorRect.hide()
