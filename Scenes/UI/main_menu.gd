extends Control
class_name MainMenu
@onready var main_buttons: Control = $MainButtons
@onready var setting_buttons: Control = $SettingButtons

# MainButtons 

func _on_play_button_pressed() -> void:
	Transiton.transition_to("res://Scenes/CharacterSelection/character_selection.tscn")


func _on_setting_button_pressed() -> void:
	# 动画位移
	var tween := create_tween();
	tween.tween_property(main_buttons,"global_position:y",350,0.2);
	tween.tween_interval(0.1);
	tween.tween_property(setting_buttons,"global_position:x",145,0.3);

func _on_quit_button_pressed() -> void:
	pass # Replace with function body.

# SettingsButtons

func _on_music_button_pressed() -> void:
	pass # Replace with function body.


func _on_sfx_button_pressed() -> void:
	pass # Replace with function body.


func _on_window_button_pressed() -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	# 动画位移
	var tween := create_tween();
	tween.tween_property(setting_buttons,"global_position:x",558,0.3);
	tween.tween_interval(0.1);
	tween.tween_property(main_buttons,"global_position:y",115,0.2);
