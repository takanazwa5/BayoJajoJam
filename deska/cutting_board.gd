class_name CuttingBoard extends TextureRect


const KNIFE_ICON: Texture2D = preload("uid://myjpeag58sgn")


var item_on_board: ItemData:

	set(value):

		item_on_board = value
		if item_on_board is ItemData:

			item_slot.texture_normal = item_on_board.sprite

		else:

			item_slot.texture_normal = null
			item_slot.set_anchors_preset(Control.PRESET_CENTER)


@onready var item_slot: TextureButton = %ItemSlot


func _ready() -> void:

	item_slot.pressed.connect(_on_item_slot_pressed)
	item_slot.mouse_entered.connect(_on_item_slot_mouse_entered)
	item_slot.mouse_exited.connect(_on_item_slot_mouse_exited)


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData and is_empty():

		if data.can_be_cut:

			return true

	return false


func _drop_data(_at_position: Vector2, data: Variant) -> void:

	item_on_board = data


func _get_drag_data(_at_position: Vector2) -> Variant:

	if is_empty(): return
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var preview_texture: TextureRect = TextureRect.new()
	preview_texture.texture = item_on_board.icon
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.size = item_on_board.icon.get_size()
	preview_texture.position = preview_texture.size * -0.5
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 99
	set_drag_preview(preview)
	item_slot.texture_normal = null
	return item_on_board


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAG_END:

		if not is_drag_successful() and not is_empty():

			item_slot.texture_normal = item_on_board.sprite

		elif not item_slot.texture_normal is Texture2D:

			item_on_board = null


func is_empty() -> bool:

	return not item_on_board is ItemData


func _on_item_slot_pressed() -> void:

	if item_on_board.can_be_cut:

		item_on_board = item_on_board.item_after_cutting
		Input.set_custom_mouse_cursor(null)


func _on_item_slot_mouse_entered() -> void:

	if is_empty(): return
	if not item_on_board.can_be_cut: return
	Input.set_custom_mouse_cursor(KNIFE_ICON)


func _on_item_slot_mouse_exited() -> void:

	Input.set_custom_mouse_cursor(null)
