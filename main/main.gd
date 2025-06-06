class_name Main extends Node


const _1HP: Texture2D = preload("uid://cfo4tm0swjaxl")
const _2HP: Texture2D = preload("uid://dne0w34c588o")
const _3HP: Texture2D = preload("uid://dgk6sfgmb7cfo")
const GAME_OVER: PackedScene = preload("uid://bw4v87ccf1e2n")


@onready var stove: Control = %Stove
@onready var workstation: Control = %Workstation
@onready var fridge: Control = %Fridge
@onready var orders: Control = %Orders
@onready var view_switcher: ViewSwitcher = %ViewSwitcher
@onready var time_left: Label = %TimeLeft
@onready var hp: TextureRect = %HP
@onready var egg_brick_1: AudioStreamPlayer = %EggBrick1


static var instance: Main

var _current_view: Control
var _previous_view: Control
var health: int = 3:

	set(value):

		health = value
		egg_brick_1.play()
		if health == 2:

			hp.texture = _2HP

		elif health == 1:

			hp.texture = _1HP


func _init() -> void:

	instance = self


func _ready() -> void:

	_current_view = fridge

	view_switcher.left_button.pressed.connect(_on_left_button_pressed)
	view_switcher.right_button.pressed.connect(_on_right_button_pressed)
	view_switcher.up_button.pressed.connect(_on_up_button_pressed)
	view_switcher.down_button.pressed.connect(_on_down_button_pressed)


func gameover() -> void:

	get_tree().change_scene_to_packed(GAME_OVER)


func _change_view(view: Control) -> void:

	await view_switcher.fade_in()
	_current_view.hide()
	view.show()
	view_switcher.fade_out()
	_previous_view = _current_view
	_current_view = view

	if _previous_view == orders:

		view_switcher.down_button.hide()
		view_switcher.left_button.show()
		view_switcher.right_button.show()
		view_switcher.up_button.show()

	match _current_view:

		fridge:

			view_switcher.right_button.hide()

		stove:

			view_switcher.left_button.hide()

		orders:

			view_switcher.left_button.hide()
			view_switcher.right_button.hide()
			view_switcher.up_button.hide()
			view_switcher.down_button.show()

		_:

			view_switcher.left_button.show()
			view_switcher.right_button.show()


func _on_left_button_pressed() -> void:

	match _current_view:

		workstation:

			_change_view(stove)

		fridge:

			_change_view(workstation)


func _on_right_button_pressed() -> void:

	match _current_view:

		stove:

			_change_view(workstation)

		workstation:

			_change_view(fridge)


func _on_up_button_pressed() -> void:

	_change_view(orders)


func _on_down_button_pressed() -> void:

	_change_view(_previous_view)
