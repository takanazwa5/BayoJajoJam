class_name Cookbook extends Control


@onready var cookbook_button: TextureButton = %CookbookButton
@onready var ksiega_menu: TextureRect = %"Ksiega-menu"
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sfx: Array[AudioStreamPlayer] = [%Ksiazka1, %Ksiazka2, %Ksiazka3, %Ksiazka4]


func _ready() -> void:

	cookbook_button.pressed.connect(_on_cookbook_button_pressed)


func _on_cookbook_button_pressed() -> void:

	if animation_player.is_playing(): return

	sfx.pick_random().play()
	if ksiega_menu.visible:

		animation_player.play(&"fade_out")

	else:

		animation_player.play(&"fade_in")
