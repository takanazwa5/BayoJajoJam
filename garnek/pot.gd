class_name Pot extends TextureRect


enum State {EMPTY, COOKING, BURNING, FUCKEDUP}


const GARNEK: Texture2D = preload("uid://crtptr63l2pfs")
const GARNEK_WODA: Texture2D = preload("uid://cy8f3whx2xhpg")
const GARNEK_JAJO: Texture2D = preload("uid://ccx5fwt0ie8mj")
const GARNEK_FUJKA: Texture2D = preload("uid://b2gduo8fd0dso")


var state: State:

	set(value):

		state = value
		if state == State.EMPTY:

			output = null
			progress_bar.value = 0.0
			timer.stop()
			texture = GARNEK
			progress_bar.hide()

		elif state == State.COOKING:

			progress_bar.value = 0.0
			timer.start()
			texture = GARNEK_JAJO
			progress_bar.show()
			label.text = "COOKING"

		elif state == State.BURNING:

			progress_bar.value = 0.0
			output = load("uid://bcak7iqi8wfaq")
			label.text = "BURNING"

		elif state == State.FUCKEDUP:

			timer.stop()
			output = load("uid://dkq6xou4skodm")
			texture = GARNEK_FUJKA
			label.text = "BURNED"

var output: ItemData


@onready var progress_bar: TextureProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@onready var label: Label = %Label


func _ready() -> void:

	progress_bar.value_changed.connect(_on_progress_bar_value_changed)
	timer.timeout.connect(_on_timer_timeout)


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData and state == State.EMPTY:

		if data.type == ItemData.Type.JAJO:

			return true

	return false


func _drop_data(_at_position: Vector2, _data: Variant) -> void:

	state = State.COOKING


func _get_drag_data(_at_position: Vector2) -> Variant:

	if not state in [State.BURNING, State.FUCKEDUP]: return
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var preview_texture: TextureRect = TextureRect.new()
	preview_texture.texture = output.icon
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.size = output.icon.get_size()
	preview_texture.position = preview_texture.size * -0.5
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 99
	set_drag_preview(preview)
	texture = GARNEK_WODA
	timer.stop()
	return output


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAG_END:

		if not is_drag_successful():

			timer.start()

			if state == State.BURNING:

				texture = GARNEK_JAJO

			if state == State.FUCKEDUP:

				texture = GARNEK_FUJKA

		elif texture == GARNEK_WODA:

			state = State.EMPTY


func _on_timer_timeout() -> void:

	progress_bar.value += 1


func _on_progress_bar_value_changed(value: float) -> void:

	if is_equal_approx(value, progress_bar.max_value):

		if state == State.COOKING:

			state = State.BURNING

		elif state == State.BURNING:

			state = State.FUCKEDUP
