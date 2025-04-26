class_name Trashcan extends TextureRect


const TRASHCAN_CLOSED: Texture2D = preload("uid://bqyj22huddo00")
const TRASHCAN_OPENED: Texture2D = preload("uid://bmpmmremy1obd")


var is_dragging: bool = false


func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	return data is ItemData


func _drop_data(_at_position: Vector2, _data: Variant) -> void:

	texture = TRASHCAN_CLOSED


func _notification(what: int) -> void:

	match what:

		NOTIFICATION_DRAG_BEGIN:

			is_dragging = true

		NOTIFICATION_DRAG_END:

			is_dragging = false


func _on_mouse_entered() -> void:

	if is_dragging:

		texture = TRASHCAN_OPENED


func _on_mouse_exited() -> void:

	texture = TRASHCAN_CLOSED
