class_name MainMenu extends Control


@onready var play_button: TextureButton = %PlayButton
@onready var credits_button: Button = %CreditsButton
@onready var how_to_play_button: Button = %HowToPlayButton


func _ready() -> void:

	play_button.pressed.connect(_on_play_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_button_pressed)


func _on_play_button_pressed() -> void:

	var main_scene: PackedScene = load("uid://77go706q5sb7")
	get_tree().change_scene_to_packed(main_scene)


func _on_credits_button_pressed() -> void:

	pass


func _on_how_to_play_button_pressed() -> void:

	pass
