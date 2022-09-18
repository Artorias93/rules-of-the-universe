extends Control

var ids = ["Percorso", "Domande", "Risp1", "Risp2", "Ind", "Ind1", "Ind2", "Avatar", "BIAS", "BonMal1", "BonMal2", "Info", "Anni", "Mesi"]
var data = {}
var json = []
var file = File.new()
var path = "res://Scenes/Game/Domande.json"
var par = {}


func _ready():
	$ColorRect.show()
	$ColorRect.color = Color(0,0,0,255)
	$ColorRect/AnimationPlayer.play("Fade-Out")
	file.open(path, File.READ)
	json = parse_json(file.get_as_text())
	for i in ids:
		if ids.find(i) == 0: continue
		json[ids.find(i)-1].erase("Percorso")
		data[i] = json[ids.find(i)-1]
		
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if $Indietro.click == 1: SceneManager.goto_scene("res://Scenes/MainMenu/MainMenu.tscn")
	elif $Avvia.click == 1: 
		par = {0:1,1:data,2:"00",3:1}
		SceneManager.goto_scene("res://Scenes/Game/One.tscn", par)
	else: $ColorRect.hide()
