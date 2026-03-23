extends CharacterBody2D

@onready var death_sound = $AudioStreamPlayer
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

enum PLAYER_STATES {READY, DEPLETED}

var speed : int = 500
var screen_size : Vector2
var player_size : Vector2
var current_state = PLAYER_STATES.READY

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_size = $CollisionShape2D.shape.get_rect().size

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("MOVE_LEFT","MOVE_RIGHT","MOVE_UP","MOVE_DOWN")
	if input_direction:
		animation.play()
	else:
		animation.stop()
	velocity = input_direction * speed
	position += velocity * _delta
	position = position.clamp(Vector2.ZERO + player_size / 2 + Vector2(100,100), screen_size - player_size / 2 - Vector2(100,100))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("STOP_TIME"):
		match current_state:
			PLAYER_STATES.READY:
				GlobalBus.time_stopped.emit()
				current_state = PLAYER_STATES.DEPLETED
				print("Che il tempo si fermi.")
			PLAYER_STATES.DEPLETED:
				pass

func die(spawn_point):
	self.global_position = spawn_point
	death_sound.play()

func recharge_player():
	current_state = PLAYER_STATES.READY
