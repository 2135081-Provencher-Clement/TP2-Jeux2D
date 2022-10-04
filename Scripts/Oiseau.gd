extends KinematicBody2D

export (int) var gravity = 10
export (int) var force_saut = 50
var velocity = Vector2.ZERO
var collision

func _process(delta):
	velocity.y = velocity.y + gravity
	
	if(Input.is_action_just_pressed("saut")):
		velocity.y = force_saut * -1 #enlève la force accumulée de la gravité
		
func _physics_process(delta):
	collision = move_and_collide(velocity * delta)
	
	if collision:
		print(collision.name)
