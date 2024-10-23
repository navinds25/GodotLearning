extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _input(event: InputEvent) -> void:
	var move = Vector2()
	if event.is_action_pressed("space"):
		print("action pressed")
		
	if event.is_action_released("space"):
		print("action released")
	if event.is_action_pressed("ui_left"):
		velocity.x = velocity.x -1
		move.x -= 1
		move_and_slide()
	if event.is_action_pressed("ui_right"):
		velocity.x = velocity.x +1
		move.x += 1
		move_and_slide()
