extends Node
class_name InfluenceableObject

enum ONTOLOGICAL_STATES {STOPPED, MOVING}
var current_state = ONTOLOGICAL_STATES.MOVING

func _ready() -> void:
	GlobalBus.time_stopped.connect(change_state)
	GlobalBus.time_restart.connect(change_state)

func change_state(arg : String):
	if arg == "time_stopped":
		current_state = ONTOLOGICAL_STATES.STOPPED
		print("STOPPED")
	if arg == "time_restart":
		current_state = ONTOLOGICAL_STATES.MOVING
		print("MOVING")
