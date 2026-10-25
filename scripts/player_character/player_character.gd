extends CharacterBody2D

@export var tile_map: TileMapLayer
@export var health := 3
var SPEED = 30
var JUMP_VELOCITY = -200
var gravity_scale = 1.0
var is_recently_hurt := false
var time_hurt_at := 0.0
var is_balloon_attached := false
var attached_balloon: Area2D
var x_friction := 0.0
var x_velocity = 0
var unboosted_balloon_gravity_scale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Around 8 blinks per second?
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_recently_hurt:
		var ms_since_start = Time.get_ticks_msec()
		%Sprite2D.visible = int(ms_since_start / 60) % 2 == 0
		
		if ms_since_start - time_hurt_at >= 2000:
			is_recently_hurt = false 
			time_hurt_at = 0.0
			return 
	else: 
		%Sprite2D.visible = true
			

func _physics_process(delta):
	
	if is_on_floor() && is_balloon_attached:
		gravity_scale = 0.5
		
	
	var direction := Input.get_axis("move_left", "move_right")
	
	
	var y_delta_v = get_gravity() * gravity_scale * delta
	
	if not is_on_floor():
		if is_in_water(): 
			y_delta_v *= 0.125
			
			
	velocity += y_delta_v
	
	if direction == 0 && is_on_floor():
		x_velocity = direction * SPEED
	elif direction != 0 && abs(x_velocity) <= abs(direction * SPEED):
		x_velocity = direction * SPEED
	# no horizontal input
	else:
		if not is_on_floor():
			x_velocity *= .965
			if is_zero_approx(x_velocity):
				x_velocity = 0
			
	#if is_on_floor():
		#print('is_on_floor')
	#else:
		#print('no')
	
	velocity.x = x_velocity
	
	#print(velocity.x)
		
		
	

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
		
		
	move_and_slide()

func hurt(amount: int) -> void:
	if is_recently_hurt: 
		return
		
	health -= abs(amount)
	get_tree().get_first_node_in_group('health_ui_component').set_hearts(health)
	if health <= 0:
		get_tree().reload_current_scene()
	
	if typeof(attached_balloon) == typeof(Area2D):
		attached_balloon.queue_free()
		is_balloon_attached = false
		set_balloon_is_attached(false, null)
		
	
	is_recently_hurt = true
	var ms_since_start = Time.get_ticks_msec()
	time_hurt_at = ms_since_start
	

func is_in_water() -> bool:
	# Find which tile cell the crab is standing in:
	# world position -> tile map's local space -> grid cell coordinates
	var cell := tile_map.local_to_map(tile_map.to_local(global_position))
	var data := tile_map.get_cell_tile_data(cell)
	return data != null and data.get_custom_data("is_water")
	
func set_balloon_is_attached(is_attached: bool, balloon: Area2D) -> void:
	is_balloon_attached = is_attached
	attached_balloon = balloon
	if is_balloon_attached:
		gravity_scale = unboosted_balloon_gravity_scale
	else:
		gravity_scale = 1.0

	
func boost(boost_direction: String):
	
	if is_balloon_attached:
		if boost_direction == 'left':
			x_velocity -= 6 * SPEED		
		elif boost_direction == 'right':
			x_velocity += 6 * SPEED
		
		velocity.y = -100
		gravity_scale = 0.125
