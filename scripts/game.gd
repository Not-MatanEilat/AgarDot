extends Node2D

@export var player_scene: PackedScene
@export var dot_scene: PackedScene

const PORT = 1335
const ADDRESS = "127.0.0.1"

var connected_ids = []
var local_player_character


func add_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	add_child(player)

func handle_player_connected(id):
	add_player(id)
