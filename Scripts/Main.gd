extends Node2D

export (PackedScene) var tuyau1
export (PackedScene) var tuyau2

onready var liste_tuyaux = [
	tuyau1,
	tuyau2
]

func _process(delta):
	print(liste_tuyaux[0])
