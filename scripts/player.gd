extends CharacterBody2D

var speed : int = 500
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("MOVE_LEFT","MOVE_RIGHT","MOVE_UP","MOVE_DOWN")
	velocity = input_direction * speed
	position += velocity * _delta
	position = position.clamp(Vector2.ZERO, screen_size)
