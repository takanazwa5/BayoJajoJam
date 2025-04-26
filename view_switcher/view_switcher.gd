class_name ViewSwitcher extends Control


@onready var left_button: TextureButton = %LeftButton
@onready var right_button: TextureButton = %RightButton
@onready var up_button: TextureButton = %UpButton
@onready var down_button: TextureButton = %DownButton
@onready var color_rect: ColorRect = %ColorRect
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func fade_in() -> void:

	color_rect.show()
	animation_player.play(&"fade_in")


func fade_out() -> void:

	animation_player.play_backwards(&"fade_in")
	await animation_player.animation_finished
	color_rect.hide()
