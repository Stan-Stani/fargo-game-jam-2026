extends Area2D

@export_enum("left", "right") var direction = "right"

@onready var player = get_tree().get_first_node_in_group('player')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if direction == 'left':
		$AnimatedSprite2D.play_backwards("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == player:
			player.boost(direction)
