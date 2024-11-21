extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("Hello world")
	$Label.text = "hello"
	$Label.modulate = Color.LIGHT_CORAL

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _input(event):
	if event.is_action_pressed("space"):
		$Label.modulate = Color.AQUA
	if event.is_action_released("space"):
		$Label.modulate = Color.BEIGE
