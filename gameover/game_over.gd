class_name GameOver extends Control


static var orders_completed: int = 0


@onready var retry_button: Button = %RetryButton
@onready var label: Label = %Label


func _ready() -> void:

	retry_button.pressed.connect(_on_retry_button_pressed)
	label.text = "Orders completed: %s" % orders_completed


func _on_retry_button_pressed() -> void:

	orders_completed = 0
	var main_scene: PackedScene = load("uid://77go706q5sb7")
	get_tree().change_scene_to_packed(main_scene)
