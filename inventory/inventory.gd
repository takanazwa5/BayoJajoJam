class_name Inventory extends Control


func _ready() -> void:

	var first_slot: InventorySlot = $MarginContainer/HBoxContainer/InventorySlot
	first_slot.item_data = load("res://items/item_data/jajo.tres")
