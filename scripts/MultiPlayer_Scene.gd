extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene

func _on_peer_connected(id):
	spawn_player(id)

func _on_peer_disconnected(id):
	despawn_player(id)
	
func host():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer	
	multiplayer.peer_connected.connect(_on_peer_connected)
	spawn_player()
	
func join():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	
func spawn_player(id=1):
	print(id)
	var player = player_scene.instantiate()
	player.set_name(str(id))
	add_child(player)  # Add the player to the multiplayer scene

func despawn_player(id):
	var player = get_tree().get_root().get_node(str(id))
	player.queue_free()

