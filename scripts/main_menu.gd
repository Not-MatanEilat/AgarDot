extends Node2D

@export var game_scene: PackedScene
 
func _on_host_pressed():
	var game = start_game()
	game.host()


 
func start_game():
	
	var game = game_scene.instantiate()
	get_tree().root.add_child(game)
	queue_free()
	
	return game
	
func _on_join_pressed():
	var game = start_game()
	game.join()

