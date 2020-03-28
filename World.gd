extends Node2D

var faim = 1
var hygiene = 1
var education = 1
var divertissement = 1

var fois_nourris = 0
var fois_laver = 0
var fois_jouer = 0
var fois_calin = 0
var fois_enseigner = 0

onready var label_faim = $Control/HBoxContainer/faim/Label
onready var label_hygiene = $Control/HBoxContainer/hygiene/Label2
onready var label_education = $Control/HBoxContainer/education/Label3
onready var label_divertissement = $Control/HBoxContainer/divertissement/Label4

onready var btn_alimenter = $Control/VBoxContainer/HBoxContainer2/Alimenter
onready var btn_jouer = $Control/VBoxContainer/HBoxContainer2/Jouer
onready var btn_calin = $Control/VBoxContainer/HBoxContainer2/Calin
onready var btn_enseigner = $Control/VBoxContainer/HBoxContainer3/Enseigner
onready var btn_laver = $Control/VBoxContainer/HBoxContainer3/Laver

func _ready():
	btn_alimenter.disabled = true
	btn_calin.disabled = true
	btn_jouer.disabled = true
	btn_laver.disabled = true
	updateTopUI()
	$Baby/AnimationPlayer.play("idle")

func updateTopUI():
	label_faim.text = str(faim)
	label_hygiene.text = str(hygiene)
	label_education.text = str(education)
	label_divertissement.text = str(divertissement)
	
func _on_Alimenter_pressed():
	$LastFaim.start()
	fois_nourris += 1
	btn_alimenter.disabled = true
	$Faim.start()
	$ApresRepas.start()
	$Jouer.set_paused(true)
	btn_calin.disabled = true
	btn_jouer.disabled = true
	if fois_nourris == 3:
		faim += 1
		fois_nourris = 0
		btn_laver.disabled = false
		updateTopUI()

func _on_Jouer_pressed():
	$LastDivertissement.start()
	fois_jouer += 1
	$Jouer.start()
	btn_jouer.disabled = true
	btn_calin.disabled = true
	if fois_jouer == 3:
		divertissement += 1
		fois_jouer = 0
		updateTopUI()

func _on_Calin_pressed():
	$LastDivertissement.start()
	fois_calin += 1
	$Jouer.start()
	btn_jouer.disabled = true
	btn_calin.disabled = true
	if fois_calin == 3:
		divertissement += 1
		fois_calin = 0
		updateTopUI()

func _on_Enseigner_pressed():
	$LastEducation.start()
	fois_enseigner += 1
	if fois_enseigner == 3:
		education += 1
		fois_enseigner = 0
		updateTopUI()

func _on_Laver_pressed():
	$LastHygiene.start()
	fois_laver += 1
	btn_laver.disabled = true
	if fois_laver == 3:
		hygiene += 1
		fois_laver = 0
		updateTopUI()

func _on_Faim_timeout():
	btn_alimenter.disabled = false

func _on_Jouer_timeout():
	btn_calin.disabled = false
	btn_jouer.disabled = false

func _on_ApresRepas_timeout():
	$Jouer.set_paused(false)

func _on_LastFaim_timeout():
	faim -= 1
	if faim < 1:
		faim = 1
	updateTopUI()


func _on_LastHygiene_timeout():
	hygiene -= 1
	if hygiene < 1:
		hygiene = 1
	updateTopUI()


func _on_LastEducation_timeout():
	education -= 1
	if education < 1:
		education = 1
	updateTopUI()


func _on_LastDivertissement_timeout():
	divertissement -= 1
	if divertissement < 1:
		divertissement = 1
	updateTopUI()
