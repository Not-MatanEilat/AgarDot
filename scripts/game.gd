extends Node2D

@export var player_scene: PackedScene
@export var dot_scene: PackedScene

const PORT = 1335
const ADDRESS = "127.0.0.1"

var local_player

func add_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	add_child(player)
	
	if id == multiplayer.get_unique_id():
		local_player = player

func handle_player_connected(id):
	add_player(id)
