extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_hearts(count: int):
	var heart_count: int = clamp(count, 0, 3)
	if heart_count == 3:
		%Heart1.show()
		%Heart2.show()
		%Heart3.show()
	elif heart_count == 2:
		%Heart1.show()
		%Heart2.show()
		%Heart3.hide()
	elif heart_count == 1:
		%Heart1.show()
		%Heart2.hide()
		%Heart3.hide()
	elif heart_count == 0:
		%Heart1.hide()
		%Heart2.hide()
		%Heart3.hide()
