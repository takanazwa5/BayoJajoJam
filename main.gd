extends Node


@onready var stove: Node2D = %Stove
@onready var workstation: Node2D = %Workstation
@onready var fridge: Node2D = %Fridge
@onready var orders: Node2D = %Orders
@onready var view_switcher: ViewSwitcher = %ViewSwitcher


var _current_view: Node2D
var _previous_view: Node2D


func _ready() -> void:

	_current_view = workstation

	view_switcher.left_button.pressed.connect(_on_left_button_pressed)
	view_switcher.right_button.pressed.connect(_on_right_button_pressed)
	view_switcher.up_button.pressed.connect(_on_up_button_pressed)
	view_switcher.down_button.pressed.connect(_on_down_button_pressed)


func _change_view(view: Node2D) -> void:

	_current_view.hide()
	view.show()
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
