extends CharacterBody2D

@export var health := 3
var SPEED = 30
var JUMP_VELOCITY = -200
var gravity_scale = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta
		
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	move_and_slide()

func hurt(amount: int) -> void:
	health -= abs(amount)
	prints('new health', health)
	
