extends Area2D

# for movement _process fn
const MOVE_SPEED = 100.0

# for constraining player to screen
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

# for firing a shot
var shot_scene = preload("res://shot.tscn")

# reloading after shot
var can_shoot = true

# destroying player
signal destroyed
var explosion_scene = preload("res://explosion.tscn")

func _process(delta):
	# for movement
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0	
	position += (delta * MOVE_SPEED) * input_dir
	
	# for constraining player to screen
	if position.x < 0.0:
		position.x = 0.0
	elif position.x > SCREEN_WIDTH:
		position.x = SCREEN_WIDTH
	if position.y < 0.0:
		position.y = 0.0
	elif position.y > SCREEN_HEIGHT:
		position.y = SCREEN_HEIGHT
	
	# for firing a shot
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage_node = get_parent()
		var shot_instance = shot_scene.instance()
		shot_instance.position = position
		stage_node.add_child(shot_instance)
		can_shoot = false
		get_node("reload_timer").start()

func _on_reload_timer_timeout():
	can_shoot = true

func _on_player_area_entered(area):
	if area.is_in_group("asteroid"):
		emit_signal("destroyed")
		queue_free()
		var stage_node = get_parent()
		var explosion_instance = explosion_scene.instance()
		stage_node.add_child(explosion_instance)
