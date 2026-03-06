extends Node2D

var player_x = 400.0
var player_w = 120.0
var player_h = 20.0
var player_speed = 520.0

var balls = []
var spawn_t = 0.0
var spawn_gap = 0.8

var score = 0
var life = 3
var game_over = false

func _ready():
	randomize()
	player_x = get_viewport_rect().size.x * 0.5

func _process(delta):
	var view = get_viewport_rect().size
	var y = view.y - 40.0

	if game_over:
		if Input.is_action_just_pressed("ui_accept"):
			_restart()
		queue_redraw()
		return

	var d = 0.0
	if Input.is_action_pressed("ui_left"):
		d -= 1.0
	if Input.is_action_pressed("ui_right"):
		d += 1.0

	player_x += d * player_speed * delta
	player_x = clamp(player_x, player_w * 0.5, view.x - player_w * 0.5)

	spawn_t += delta
	if spawn_t >= spawn_gap:
		spawn_t = 0.0
		balls.append({
			"p": Vector2(randf_range(20.0, view.x - 20.0), -20.0),
			"v": randf_range(180.0, 320.0),
			"r": randi_range(10, 16)
		})

	for i in range(balls.size() - 1, -1, -1):
		var b = balls[i]
		b["p"].y += b["v"] * delta

		var hit_x = abs(b["p"].x - player_x) <= (player_w * 0.5 + b["r"])
		var hit_y = abs(b["p"].y - y) <= (player_h * 0.5 + b["r"])

		if hit_x and hit_y:
			score += 1
			balls.remove_at(i)
			continue

		if b["p"].y > view.y + 30.0:
			life -= 1
			balls.remove_at(i)
			if life <= 0:
				game_over = true

	queue_redraw()

func _draw():
	var view = get_viewport_rect().size
	var y = view.y - 40.0

	draw_rect(
		Rect2(player_x - player_w * 0.5, y - player_h * 0.5, player_w, player_h),
		Color(0.2, 0.7, 1.0)
	)

	for b in balls:
		draw_circle(b["p"], b["r"], Color(1.0, 0.6, 0.2))

func _restart():
	score = 0
	life = 3
	game_over = false
	spawn_t = 0.0
	balls.clear()
	player_x = get_viewport_rect().size.x * 0.5
