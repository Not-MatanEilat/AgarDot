extends Node2D

@export var game_scene: PackedScene
var peer 

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connect_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func player_connected(id):
	print("Player connected " + str(id))
	
func player_disconnected(id):
	print("Player disconnected " + str(id))
	
func connect_to_server():
	print("Connected to server!")

func connection_failed():
	print("Couldn't connect")



func _on_host_pressed():
	var game = start_game()
	game.game_host()
	print("Waiting for players")
	
func _on_join_pressed():
	var game = start_game()
	game.game_join()
	
func start_game():
	var game = game_scene.instantiate()
	get_tree().root.add_child(game)
	queue_free()
	return game
