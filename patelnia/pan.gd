class_name Pan extends TextureButton


enum State {EMPTY, COOKING, BURNING, FUCKEDUP}


const PATELNIA: Texture2D = preload("uid://c3kuv1bbegemf")
const PATELNIA_JAJO_SADZONE: Texture2D = preload("uid://0r0fbr4ql3ve")
const PATELNIA_JAJO_ZEPSUTE: Texture2D = preload("uid://d1u8quoi4prdv")
const PATELNIA_JAJUWA: Texture2D = preload("uid://duox086bc666v")
const PATELNIA_OMLET: Texture2D = preload("uid://c3lbrg2f5k50a")
const PATELNIA_SHAKSHUKA: Texture2D = preload("uid://ds7db2cf1v15o")


var state: State = State.EMPTY:

	set(value):

		if state == value: return
		state = value
		match state:

			State.EMPTY:

				output = null
				progress_bar.value = 0.0
				timer.stop()
				texture_normal = PATELNIA
				progress_bar.hide()
				contents["eggs"] = 0
				contents["tomato"] = 0
				contents["omlet_raw"] = 0
				stirred = false

			State.COOKING:

				progress_bar.value = 0.0
				timer.start()
				if contents["tomato"] == 1:

					texture_normal = PATELNIA_SHAKSHUKA

				elif contents["eggs"] == 3 and stirred:

					texture_normal = PATELNIA_JAJUWA

				elif contents["eggs"] == 1:

					texture_normal = PATELNIA_JAJO_SADZONE

				elif contents["omlet_raw"] == 1:

					texture_normal = PATELNIA_OMLET

				else:

					texture_normal = PATELNIA_JAJO_ZEPSUTE

				progress_bar.show()
				label.text = "COOKING"

			State.BURNING:

				progress_bar.value = 0.0
				if contents["eggs"] == 2 and contents["tomato"] == 1:

					output = load("uid://dmobuqrx2l26q")

				elif contents["eggs"] == 3 and stirred:

					output = load("uid://bnov7tain11n7")

				elif contents["eggs"] == 1:

					output = load("uid://bjslote6cn7x7")

				elif contents["omlet_raw"] == 1:

					output = load("uid://d2aogmwvbrqhm")

				else:

					output = load("uid://dkq6xou4skodm")
					if contents["eggs"] == 3 and not stirred:

						texture_normal = PATELNIA_JAJO_ZEPSUTE

				label.text = "BURNING"

			State.FUCKEDUP:

				timer.stop()
				output = load("uid://dkq6xou4skodm")
				texture_normal = PATELNIA_JAJO_ZEPSUTE
				label.text = "BURNED"
				progress_bar.value = progress_bar.max_value
				contents["eggs"] = 0
				contents["tomato"] = 0
				contents["omlet_raw"] = 0

var stirred: bool = false
var output: ItemData
var contents: Dictionary[String, int] = {
	"eggs": 0,
	"tomato": 0,
	"omlet_raw": 0,
}


@onready var progress_bar: TextureProgressBar = %ProgressBar
@onready var label: Label = %Label
@onready var timer: Timer = %Timer


func _ready() -> void:

	progress_bar.value_changed.connect(_on_progress_bar_value_changed)
	timer.timeout.connect(_on_timer_timeout)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData and state in [State.EMPTY, State.COOKING]:

		if data.can_be_cooked:

			return true

	return false


func _drop_data(_at_position: Vector2, data: Variant) -> void:

	if data.type == ItemData.Type.JAJO:

		contents["eggs"] += 1

		if contents["eggs"] == 3:

			Input.set_custom_mouse_cursor(Bowl.LYZKA_ICON)

		elif contents["eggs"] == 2 and contents["tomato"] == 1:

			texture_normal = PATELNIA_SHAKSHUKA

	elif data.type == ItemData.Type.POMIDOR:

		contents["tomato"] += 1

	elif data.type == ItemData.Type.OMLET_RAW:

		contents["omlet_raw"] += 1

	if contents["eggs"] > 3 \
	or contents["tomato"] > 1 \
	or contents["omlet_raw"] > 1 \
	or (contents["omlet_raw"] > 0 and (contents["eggs"] > 0 or contents["tomato"] > 0)):

		state = State.FUCKEDUP

	else:

		state = State.COOKING


func _get_drag_data(_at_position: Vector2) -> Variant:

	if not state in [State.BURNING, State.FUCKEDUP] or not output is ItemData: return
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
	texture_normal = PATELNIA
	timer.stop()
	return output


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAG_END:

		if not is_drag_successful():

			timer.start()

			if state == State.BURNING:

				if contents["eggs"] == 2 and contents["tomato"] == 1:

					texture_normal = PATELNIA_SHAKSHUKA

				elif contents["eggs"] == 3 and stirred:

					texture_normal = PATELNIA_JAJUWA

				elif contents["eggs"] == 1:

					texture_normal = PATELNIA_JAJO_SADZONE

				elif contents["omlet_raw"] == 1:

					texture_normal = PATELNIA_OMLET

			elif state == State.FUCKEDUP:

				texture_normal = PATELNIA_JAJO_ZEPSUTE

		elif output is ItemData:

			state = State.EMPTY


func _on_timer_timeout() -> void:

	progress_bar.value += 1.0


func _on_progress_bar_value_changed(value: float) -> void:

	if is_equal_approx(value, progress_bar.max_value):

		if state == State.COOKING:

			state = State.BURNING

		elif state == State.BURNING:

			state = State.FUCKEDUP


func _on_mouse_entered() -> void:

	if state == State.COOKING and contents["eggs"] == 3 and not stirred:

		Input.set_custom_mouse_cursor(Bowl.LYZKA_ICON)


func _on_mouse_exited() -> void:

	Input.set_custom_mouse_cursor(null)


func _on_pressed() -> void:

	if not contents["eggs"] == 3 and not stirred: return
	stirred = true
	Input.set_custom_mouse_cursor(null)
	texture_normal = PATELNIA_JAJUWA
