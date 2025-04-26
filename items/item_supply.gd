class_name ItemSupply extends Control


const HAND_ICON: Texture2D = preload("uid://b441vvkqypjj3")


@export var item_data: ItemData


@onready var sfx: Array[AudioStreamPlayer] = [%TakeBase1, %TakeBase2, %TakeBase3]


func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _get_drag_data(_at_position: Vector2) -> Variant:

	sfx[randi_range(0, 2)].play()
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var preview_texture: TextureRect = TextureRect.new()
	preview_texture.texture = item_data.icon
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.size = preview_texture.texture.get_size()
	preview_texture.position = preview_texture.size * -0.5
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 99
	set_drag_preview(preview)
	return item_data.duplicate()


func _on_mouse_entered() -> void:

	Input.set_custom_mouse_cursor(HAND_ICON)


func _on_mouse_exited() -> void:

	Input.set_custom_mouse_cursor(null)
