extends Node2D

var is_game_over = false

# spawning asteroids and keeping score
var asteroid = preload("res://asteroid.tscn")
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var score = 0

func _ready():
	# restart game
	get_node("player").connect("destroyed", Callable(self, "_on_player_destroyed"))
	# spawn asteroids
	get_node("spawn_timer").connect("timeout", Callable(self, "on_spawn_timer_timeout"))

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_game_over and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to_file("res://stage.tscn")

func _on_player_destroyed():
	get_node("ui/retry").show()
	is_game_over = true

func on_spawn_timer_timeout():
	var asteroid_instance = asteroid.instantiate()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, randf_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect("score", Callable(self, "_on_player_score"))
	add_child(asteroid_instance)

func _on_player_score():
	score += 1
	get_node("ui/score").text = "Score: " + str(score)
