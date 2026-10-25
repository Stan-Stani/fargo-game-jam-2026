extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win(): 
	# freeze scene:
	# share how fast you finished in the comments
	# add replay button 
	get_tree().paused = true
	%WIN.show()
	%Button.show()
	pass


func _on_win_area_2d_body_entered(body: Node2D) -> void:
	if body == $PlayerCharacter:
		win()
