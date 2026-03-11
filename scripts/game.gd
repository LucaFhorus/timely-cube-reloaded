extends Node

@onready var platform = $Platform
@onready var start_position = $StartPoint.global_position
@onready var end_position = $EndPoint.global_position
@onready var player = $Player
@onready var spawn_point = $SpawnLocation.global_position
@onready var prize_point = $PrizeLocation.global_position
@onready var tip = $CenterContainer
@onready var tip_label = $CenterContainer/LabelTip
@onready var za_warudo_timer : Timer = $Timers/ZaWarudoTimer
@onready var clock_sound_timer : Timer = $Timers/ClockSoundTimer
@onready var clock_sound_effect : AudioStreamPlayer = $Audio/ClockSoundEffect
@onready var za_warudo_sound_effect : AudioStreamPlayer = $Audio/ZaWarudoSoundEffect
@onready var za_warudo_end_sound_effect : AudioStreamPlayer = $Audio/ZaWarudoEndSoundEffect
@onready var prize = $Prize
@onready var font = $CenterContainer/LabelTip.get_theme_font("string_name", "")

var times_player_died : int
var new_font_size = 16


func _ready() -> void:
	platform.body_entered.connect(player_die)
	GlobalBus.time_stopped.connect(stop_time)
	za_warudo_timer.timeout.connect(restart_time)
	clock_sound_timer.timeout.connect(play_clock_sound_effect)
	prize.body_entered.connect(player_win)
	
	platform.loop_platform(start_position, end_position)
	
	player.global_position = spawn_point
	tip.global_position = spawn_point
	prize.global_position = prize_point

func _physics_process(delta: float) -> void:
	pass


func player_die(body):
	if player.current_state == player.PLAYER_STATES.DEPLETED:
		pass
	else:
		times_player_died += 1
		
		if times_player_died == 3:
			tip.visible = true
		
		if times_player_died > 3:
			if new_font_size < 400:
				new_font_size = new_font_size * 2
				tip_label.add_theme_font_size_override("font_size", new_font_size)
		
		body.die(spawn_point)


func stop_time():
	platform.stop_platform()
	za_warudo_sound_effect.play()
	await za_warudo_sound_effect.finished
	za_warudo_timer.start()
	clock_sound_timer.start()


func restart_time():
	clock_sound_timer.stop()
	za_warudo_end_sound_effect.play()
	await za_warudo_end_sound_effect.finished
	platform.restart_platform()
	player.recharge_player()


func play_clock_sound_effect():
	clock_sound_effect.play()
	
func player_win(body):
	get_tree().change_scene_to_file("res://scenes/endgame.tscn")
	print("Ho vinto")
