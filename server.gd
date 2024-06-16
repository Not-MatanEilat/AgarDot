extends Node

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
var game

const SERVER_IP = "127.0.0.1"
const PORT = 1335

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connection_failed.connect(connected_fail)
	multiplayer.server_disconnected.connect(server_disconnected)
	
	
func connect_to_server():
	multiplayer.connected_to_server.connect(connected_ok)
	peer.create_client(SERVER_IP, PORT)
	multiplayer.multiplayer_peer = peer
	
	print("connected")
	
func connected_ok():
	print("Successfully connected to server")
	
func player_connected(id):
	print("Player " + str(id) + " connected")
	
	# no need to handle the server connecting
	if id == 1:
		return
	
	if game:
		game.handle_player_connected(id)
	
func player_disconnected(id):
	print("Player " + str(id) + " disconnected")
	
func connected_fail():
	print("Failed to connect")
	
func server_disconnected():
	print("Server disconnected")
	
	
@rpc
func add_dot(dot):
	print("calling")
	game.add_dot(dot)
	

	

