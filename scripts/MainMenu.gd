extends Node2D

@export var game_scene: PackedScene

	
func _on_join_pressed():
	var game = game_scene.instantiate()
	Server.game = game
	Server.connect_to_server()
	change_scene_to_game(game)
	
	game.add_player(multiplayer.get_unique_id())
	
func change_scene_to_game(game):
	get_tree().root.add_child(game)
	queue_free()
	
