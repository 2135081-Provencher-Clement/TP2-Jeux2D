extends KinematicBody2D

export (int) var gravity = 10
export (int) var force_saut = 50
var velocity = Vector2.ZERO
var collision

#variables pour la rotation -- 
var inclinaisonMax = 0.7853982 # inclinaison en radian (45 degrés)
var currentInclinaison = 0 # stocke l'état d'inclinaison du personnage
const vitesse_rotation = 5.0 # stocke la vitesse de rotation du personnage

var isMax = false # permet de savoir si le personnage a terminé de s'incliner
var isRotate = false # permet de savoir si le personnage doit recommencer son animation de rotation


func _process(delta):
	velocity.y = velocity.y + gravity
	
	if(Input.is_action_just_pressed("saut")):
		velocity.y = force_saut * -1 #enlève la force accumulée de la gravité
		isRotate = true
		_genererParticules() # on génère les particules pour l'animation de saut
		

	if isRotate == true:
		if isMax == false:
			_rotateNezHaut(delta)
		else:
			_rotateNezBas(delta)


func _physics_process(delta):
	move_and_collide(velocity*delta)



#Fonction qui gère l'inlinaison vers le haut du personnage
#param providedDelta = le delta de la fonction _process_delta()
func _rotateNezHaut(providedDelta):
	var inclinaisonFinale = vitesse_rotation * providedDelta

	if currentInclinaison - inclinaisonFinale <= -inclinaisonMax:
		inclinaisonFinale = inclinaisonMax + currentInclinaison
		print("le max a été atteint")
		isMax = true

	currentInclinaison -= inclinaisonFinale
	#print(currentInclinaison)
	rotate(-inclinaisonFinale)

#Fonction qui gère l'inlinaison vers le bas du personnage
#param providedDelta = le delta de la fonction _process_delta()
func _rotateNezBas(providedDelta):
	var inclinaisonFinale = vitesse_rotation * providedDelta

	if currentInclinaison + inclinaisonFinale >= 0:
		inclinaisonFinale = abs(currentInclinaison)
		print("le max a été atteint")
		isMax = false
		isRotate = false

	currentInclinaison += inclinaisonFinale
	#print(currentInclinaison)
	rotate(inclinaisonFinale)


#Fonction qui gère la génération de particules du personnage
func _genererParticules():
	print("Particules générées")
	get_node("CPUParticlesOiseau").emitting = true

	
