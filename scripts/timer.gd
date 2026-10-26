extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@export var start_time := 20
func _on_timeout() -> void:
	start_time -= 1
	%TimerRichTextLabel.text = str(start_time)
	if start_time <= 0:
		get_tree().reload_current_scene()
