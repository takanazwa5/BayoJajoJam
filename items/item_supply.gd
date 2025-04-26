class_name ItemSupply extends TextureRect


@export var item_data: ItemData


func _get_drag_data(_at_position: Vector2) -> Variant:

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var preview_texture: TextureRect = TextureRect.new()
	preview_texture.texture = item_data.icon
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.size = preview_texture.texture.get_size()
	preview_texture.position = preview_texture.size * -0.5
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	return item_data.duplicate()
