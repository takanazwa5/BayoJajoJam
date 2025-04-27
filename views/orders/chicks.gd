class_name Chicks extends Control


const JAJUWA: ItemData = preload("uid://bnov7tain11n7")
const KOGEL: ItemData = preload("uid://bbtuoga42htye")
const NAMIEKKO: ItemData = preload("uid://bcak7iqi8wfaq")
const OMLET: ItemData = preload("uid://d2aogmwvbrqhm")
const SADZONE: ItemData = preload("uid://bjslote6cn7x7")
const SHAKSHUKA: ItemData = preload("uid://dmobuqrx2l26q")
const DISHES: Array[ItemData] = [JAJUWA, KOGEL, NAMIEKKO, OMLET, SADZONE, SHAKSHUKA]
const TIME_LIMIT: int = 5


var fails: int = 0:

	set(value):

		fails = value
		if fails == 3:

			Main.instance.gameover()

var current_order: ItemData
var time_left: int = TIME_LIMIT:

	set(value):

		time_left = value
		if time_left == 0:

			_generate_new_order()
			fails += 1


@onready var label: Label = %Label
@onready var timer: Timer = %Timer


func _ready() -> void:

	timer.timeout.connect(_on_timer_timeout)
	_generate_new_order()
	GameOver.orders_completed += 2


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData:

		if data.resource_path == current_order.resource_path:

			return true

	return false


func _drop_data(_at_position: Vector2, _data: Variant) -> void:

	_generate_new_order()
	GameOver.orders_completed += 1


func _generate_new_order() -> void:

	var random_pick: ItemData = DISHES.pick_random()
	while random_pick == current_order:
		random_pick = DISHES.pick_random()
	current_order = random_pick
	Dymek.instance.icon.texture = current_order.icon
	time_left = TIME_LIMIT
	label.text = str(time_left)


func _complete_order() -> void:

	_generate_new_order()


func _on_timer_timeout() -> void:

	time_left -= 1
	label.text = str(time_left)
