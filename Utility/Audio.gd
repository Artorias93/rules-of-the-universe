extends Control

var ost = load("res://SFX/Theme.ogg")
var game = load("res://SFX/Game.ogg")
var slide = load("res://SFX/Slide.wav")
var malus = load("res://SFX/Malus.wav")
var bonus = load("res://SFX/Bonus.wav")
var bias = load("res://SFX/Bias.wav")
var lose = load("res://SFX/GameOver.wav")
var win = load("res://SFX/Win.ogg")
var choice = load("res://SFX/Choice.wav")

func _ready():
	play_music("ost")
	

func play_music(mus):
	if mus == "ost":
		$Music.stream = ost
	if mus == "game":
		$Music.stream = game
	$Music.play()
	

func play_effects(sfx):
	if sfx == "slide":
		$Effects.stream = slide
		$Effects.play()
	if sfx == "malus":
		$Effects.stream = malus
		$Effects.play()
	if sfx == "bonus":
		$Effects.stream = bonus
		$Effects.play()
	if sfx == "bias":
		$Effects.stream = bias
		$Effects.play()
	if sfx == "lose":
		$Effects.stream = lose
		$Effects.play()
	if sfx == "win":
		$Effects.stream = win
		$Effects.play()
	if sfx == "choice":
		$Effects.stream = choice
		$Effects.play()
		
func stop_sfx():
	$Effects.stop()
