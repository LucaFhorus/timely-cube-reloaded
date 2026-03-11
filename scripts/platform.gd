extends Area2D

var screen_size
enum PHYSIC_STATES {MOVING, FROZEN}
var tween : Tween = create_tween().set_loops()



func _ready() -> void:
	screen_size = get_viewport_rect().size
	self.global_position = screen_size / 2



func _physics_process(delta: float) -> void:
	pass


func loop_platform(start_position : Vector2, end_position : Vector2):
	tween.tween_property(self, "global_position", start_position, 0.05)
	tween.tween_property(self, "global_position", end_position, 0.05)


func stop_platform():
	tween.pause()


func restart_platform():
	tween.play()
