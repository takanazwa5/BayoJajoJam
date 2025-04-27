class_name MainMenu extends Control


@onready var play_button: Button = %PlayButton
@onready var credits_button: Button = %CreditsButton
@onready var how_to_play_button: Button = %HowToPlayButton
@onready var credits_page: TextureRect = %CreditsPage
@onready var tutorial_page: TextureRect = %TutorialPage


func _ready() -> void:

	play_button.pressed.connect(_on_play_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_button_pressed)


func _on_play_button_pressed() -> void:

	var main_scene: PackedScene = load("uid://77go706q5sb7")
	get_tree().change_scene_to_packed(main_scene)


func _on_credits_button_pressed() -> void:

	tutorial_page.hide()
	credits_page.visible = not credits_page.visible


func _on_how_to_play_button_pressed() -> void:

	credits_page.hide()
	tutorial_page.visible = not tutorial_page.visible
