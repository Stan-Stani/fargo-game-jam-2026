extends Area2D

var player: CharacterBody2D
@onready var START_POS := position
@export_enum("left", "right") var direction = "right"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	var direction_term := 1 if direction == 'right' else -1
	# 60 tics per second; 30 px per second
	position += Vector2(0.5, 0) * direction_term
	
	if position.x >= START_POS.x + 30 \
	|| position.x <= START_POS.x - 30:
		if direction == 'right':
			direction = 'left'
			%AnimatedSprite2D.flip_h = true
		elif direction == 'left':
			direction = 'right'
			%AnimatedSprite2D.flip_h = false
			
			
	


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.hurt(1)
	
