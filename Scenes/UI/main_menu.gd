extends Control
class_name MainMenu
@onready var main_buttons: Control = $MainButtons
@onready var setting_buttons: Control = $SettingButtons
@onready var ui_sound: AudioStreamPlayer = $UISound
@onready var music_label: Label = %MusicLabel
@onready var sfx_label: Label = %SFXLabel
@onready var window_label: Label = %WindowLabel

func  update_audio_bus(bus_name: String, label: Label, is_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus_name),not is_on);
	label.text = "%s: %s" % [bus_name,"ON" if is_on else "OFF"];
	

func _ready() -> void:
	Global.load_data();
	update_audio_bus("Music",music_label,Global.settings.music);
	update_audio_bus("SFX",sfx_label,Global.settings.sfx);
	update_fullscreen(Global.settings.fullscreen);
	
	
func update_fullscreen(is_on: bool) -> void:
	var mode = DisplayServer.WINDOW_MODE_FULLSCREEN if is_on else DisplayServer.WINDOW_MODE_WINDOWED;
	DisplayServer.window_set_mode(mode);
	window_label.text = "FULLSCREEN" if is_on else "WINDOW";

# MainButtons 

func _on_play_button_pressed() -> void:
	ui_sound.play()
	Transiton.transition_to("res://Scenes/CharacterSelection/character_selection.tscn")


func _on_setting_button_pressed() -> void:
	ui_sound.play()
	# 动画位移
	var tween := create_tween();
	tween.tween_property(main_buttons,"global_position:y",350,0.2);
	tween.tween_interval(0.1);
	tween.tween_property(setting_buttons,"global_position:x",145,0.3);

func _on_quit_button_pressed() -> void:
	ui_sound.play()
	Global.save_data()
	get_tree().quit()

# SettingsButtons

func _on_music_button_pressed() -> void:
	ui_sound.play()
	# true 为设置静音， false 为设置不静音
	#AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),true);
	# 替换为新方法
	Global.settings.music = not Global.settings.music
	update_audio_bus("Music",music_label, Global.settings.music);

func _on_sfx_button_pressed() -> void:
	ui_sound.play()
	#AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),true);
	Global.settings.sfx = not Global.settings.sfx
	update_audio_bus("SFX",sfx_label, Global.settings.sfx);


func _on_window_button_pressed() -> void:
	ui_sound.play()
	Global.settings.fullscreen = not Global.settings.fullscreen
	update_fullscreen(Global.settings.fullscreen);


func _on_back_button_pressed() -> void:
	ui_sound.play()
	# 动画位移
	var tween := create_tween();
	tween.tween_property(setting_buttons,"global_position:x",558,0.3);
	tween.tween_interval(0.1);
	tween.tween_property(main_buttons,"global_position:y",115,0.2);

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.save_data()
		get_tree().quit()
