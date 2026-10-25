extends Area2D

var player: CharacterBody2D
var is_player_attached := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_attached:
		position = player.position
	



func _on_body_entered(body: Node2D) -> void:
	if body == player && !is_player_attached:
		is_player_attached = true
		player.gravity_scale = .5
	
