extends Node2D

var peer
@export var player_scene: PackedScene
@export var mass_dot_scene: PackedScene

func _on_peer_connected(id):
	spawn_player(id)

func _on_peer_disconnected(id):
	despawn_player(id)
	
func game_host():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(135)
	if error != OK:
		print("CANNOT HOST " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	multiplayer.peer_connected.connect(_on_peer_connected)
	spawn_player()
	
func game_join():
	peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	
	
func spawn_player(id=1):
	print(id)
	var player = player_scene.instantiate()
	player.set_name(str(id))
	add_child(player)  # Add the player to the multiplayer scene

func despawn_player(id):
	var player = get_tree().get_root().get_node(str(id))
	player.queue_free()
	
func _ready():
	$mass_dots_timer.start()

func _on_mass_dots_timer_timeout():
	spawn_mass_dot.rpc_id(1)
	
@rpc("call_local")
func spawn_mass_dot():
	var random_x = randf_range(0, 1500.0)
	var random_y = randf_range(0, 1500.0)
	var mass_dot = mass_dot_scene.instantiate()
	mass_dot.position = Vector2(random_x, random_y)
	mass_dot.name = str(randf())
	add_child(mass_dot)
	
