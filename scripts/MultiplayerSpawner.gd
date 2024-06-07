extends MultiplayerSpawner

@export var player_scene: PackedScene

func spawn_player(id=1):
	print(id)
	var player = player_scene.instantiate()
	player.set_name(str(id))
	add_child(player)  # Add the player to the multiplayer scene

func despawn_player(id):
	var player = get_tree().get_root().get_node(str(id))
	player.queue_free()
