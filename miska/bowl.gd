class_name Bowl extends TextureRect


enum State {EMPTY, UNFINISHED, FUCKEDUP, FINISHED, MIXING_REQUIRED}
enum Output {OMLET, KOGEL}


const MISKA: Texture2D = preload("uid://dug8j58tsqalh")
const MISKA_FUJKA: Texture2D = preload("uid://bf2dq7ypc0klm")
const MISKA_UNFINISHED: Texture2D = preload("uid://b154k02fuvy6c")
const MISKA_KOGEL: Texture2D = preload("uid://dvayr3ss2sv73")
const MISKA_OMLET: Texture2D = preload("uid://cjmteni0v0ovt")


var contents: Dictionary[String, int] = {
	"eggs": 0,
	"sugar": 0,
	"broccoli": 0,
	"misc": 0,
}

var state: State = State.EMPTY:

	set(value):

		state = value
		match state:

			State.FUCKEDUP:

				output = load("uid://wu6lfxhyx6ck")
				texture = MISKA_FUJKA

			State.MIXING_REQUIRED:

				mix_button.show()

			State.UNFINISHED:

				texture = MISKA_UNFINISHED

			State.EMPTY:

				texture = MISKA
				contents["eggs"] = 0
				contents["sugar"] = 0
				contents["broccoli"] = 0
				contents["misc"] = 0

			State.FINISHED:

				if output.get_meta(&"what") == Output.OMLET:

					texture = MISKA_OMLET

				elif output.get_meta(&"what") == Output.KOGEL:

					texture = MISKA_KOGEL

var output: ItemData


@onready var mix_button: Button = %MixButton


func _ready() -> void:

	mix_button.pressed.connect(_on_mix_button_pressed)


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData:

		if data.type == ItemData.Type.READY \
		or state in [State.FUCKEDUP, State.FINISHED, State.MIXING_REQUIRED]:

			return false

		return true

	return false


func _drop_data(_at_position: Vector2, data: Variant) -> void:

	match data.type:

		ItemData.Type.JAJO:

			contents["eggs"] += 1

		ItemData.Type.CUKIER:

			contents["sugar"] += 1

		ItemData.Type.BROKUL:

			contents["broccoli"] += 1

		_:

			contents["misc"] += 1

	if contents["eggs"] > 2 \
	or contents["sugar"] > 1 \
	or contents["broccoli"] > 1 \
	or contents["misc"] > 0 \
	or (contents["sugar"] > 0 and contents["broccoli"] > 0) \
	or (contents["sugar"] > 0 and contents["broccoli"] > 0 and contents["eggs"] > 0):

		state = State.FUCKEDUP

	elif contents["eggs"] == 1 and contents["sugar"] == 1:

		state = State.MIXING_REQUIRED

	elif contents["eggs"] == 2 and contents["broccoli"] == 1:

		state = State.MIXING_REQUIRED

	else:

		state = State.UNFINISHED


func _get_drag_data(_at_position: Vector2) -> Variant:

	if state in [State.EMPTY, State.UNFINISHED, State.MIXING_REQUIRED]: return
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
	texture = MISKA
	return output


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAG_END:

		if not is_drag_successful():

			match state:

				State.FUCKEDUP:

					texture = MISKA_FUJKA

				State.FINISHED:

					if output.get_meta(&"what") == Output.OMLET:

						texture = MISKA_OMLET

					elif output.get_meta(&"what") == Output.KOGEL:

						texture = MISKA_KOGEL

		elif texture == MISKA:

			state = State.EMPTY


func _on_mix_button_pressed() -> void:

	mix_button.hide()
	if contents["eggs"] == 1 and contents["sugar"] == 1:

		output = load("uid://bbtuoga42htye")
		output.set_meta(&"what", Output.KOGEL)

	elif contents["eggs"] == 2 and contents["broccoli"] == 1:

		output = load("uid://d2aogmwvbrqhm")
		output.set_meta(&"what", Output.OMLET)

	state = State.FINISHED
