class_name ViewSwitcher extends Control


@onready var left_button: TextureButton = %LeftButton
@onready var right_button: TextureButton = %RightButton
@onready var up_button: TextureButton = %UpButton
@onready var down_button: TextureButton = %DownButton
@onready var color_rect: ColorRect = %ColorRect
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var aim: AudioStreamPlayer = %Aim


func _ready() -> void:

	left_button.pressed.connect(_on_arrow_pressed)
	right_button.pressed.connect(_on_arrow_pressed)
	up_button.pressed.connect(_on_arrow_pressed)
	down_button.pressed.connect(_on_arrow_pressed)


func fade_in() -> void:

	animation_player.play(&"fade_in")
	await animation_player.animation_finished


func fade_out() -> void:

	animation_player.play(&"fade_out")


func _on_arrow_pressed() -> void:

	aim.play()
