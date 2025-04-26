class_name InventorySlot extends TextureRect


var item_data : ItemData:

	set(value):

		item_data = value
		texture_rect.texture = item_data.icon if item_data is ItemData else null


@onready var texture_rect: TextureRect = %TextureRect


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	return data is ItemData and is_empty()


func _drop_data(_at_position: Vector2, data: Variant) -> void:

	assert(data is ItemData)
	item_data = data


func _get_drag_data(_at_position: Vector2) -> Variant:

	if is_empty(): return
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var preview_texture: TextureRect = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.size = texture_rect.texture.get_size()
	preview_texture.position = preview_texture.size * -0.5
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	texture_rect.texture = null
	return item_data


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAG_END:

		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if not is_drag_successful() and not is_empty():

			texture_rect.texture = item_data.icon

		elif not texture_rect.texture is Texture2D:

			item_data = null


func is_empty() -> bool:

	return not item_data is ItemData
