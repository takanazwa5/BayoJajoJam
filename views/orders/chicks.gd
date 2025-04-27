class_name Chicks extends Control


const JAJUWA: ItemData = preload("uid://bnov7tain11n7")
const KOGEL: ItemData = preload("uid://bbtuoga42htye")
const NAMIEKKO: ItemData = preload("uid://bcak7iqi8wfaq")
const OMLET: ItemData = preload("uid://d2aogmwvbrqhm")
const SADZONE: ItemData = preload("uid://bjslote6cn7x7")
const SHAKSHUKA: ItemData = preload("uid://dmobuqrx2l26q")
const DISHES: Array[ItemData] = [JAJUWA, KOGEL, NAMIEKKO, OMLET, SADZONE, SHAKSHUKA]
const TIME_LIMIT: int = 45


var amamam_sfx: Array[AudioStreamPlayer]
var ueee_sfx: Array[AudioStreamPlayer]
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
			Main.instance.health -= 1


@onready var timer: Timer = %Timer
@onready var ready_dish: TextureRect = %ReadyDish
@onready var ueee: Node = %UEEE
@onready var am_am_am: Node = %AmAmAm


func _ready() -> void:

	for child: Node in am_am_am.get_children():

		if child is AudioStreamPlayer:

			amamam_sfx.append(child)

	for child: Node in ueee.get_children():

		if child is AudioStreamPlayer:

			ueee_sfx.append(child)

	get_parent().visibility_changed.connect(_on_parent_visibility_changed)
	timer.timeout.connect(_on_timer_timeout)
	await Main.instance.ready
	_generate_new_order()


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:

	if data is ItemData:

		if data.resource_path == current_order.resource_path:

			return true

	return false


func _drop_data(_at_position: Vector2, _data: Variant) -> void:

	GameOver.orders_completed += 1
	ready_dish.texture = current_order.plate_sprite
	_generate_new_order()


func _generate_new_order() -> void:

	var random_pick: ItemData = DISHES.pick_random()
	while random_pick == current_order:
		random_pick = DISHES.pick_random()
	current_order = random_pick
	Dymek.instance.icon.texture = current_order.icon
	time_left = TIME_LIMIT
	Main.instance.time_left.text = str(time_left)


func _complete_order() -> void:

	_generate_new_order()


func _on_timer_timeout() -> void:

	time_left -= 1
	Main.instance.time_left.text = str(time_left)


func _on_parent_visibility_changed() -> void:

	if not get_parent().visible:

		if ready_dish.texture is Texture2D:

			amamam_sfx.pick_random().play()

		ready_dish.texture = null
