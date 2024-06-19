extends CharacterBody2D

@export var speed = 200
@export var dead_zone = 10.0
var mouse_position = null

@export var starting_mass: int = 10
var mass = starting_mass
const MASS_TO_SCALE_RATE: float = 0.10

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	scale = Vector2(starting_mass * MASS_TO_SCALE_RATE, starting_mass * MASS_TO_SCALE_RATE)

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

func add_mass(mass_to_add):
	mass += mass_to_add
	scale = Vector2(mass * MASS_TO_SCALE_RATE, mass * MASS_TO_SCALE_RATE)
	global_position.x -= (mass_to_add * 5)
	global_position.y -= (mass_to_add * 5)
