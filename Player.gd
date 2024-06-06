extends CharacterBody2D

@export var speed = 200
@export var dead_zone = 10.0
var mouse_position = null

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _physics_process(delta):
	
	if is_multiplayer_authority():
		mouse_position = get_global_mouse_position()
		var collision_center = $CollisionShape2D.global_position
		var direction = (mouse_position - collision_center).normalized()
		velocity = (direction * speed)
		# if mouse is really close to the middle of the player, stop moving
		if (mouse_position - collision_center).length() <= dead_zone:
			velocity = Vector2(0, 0)
	
	move_and_slide()
