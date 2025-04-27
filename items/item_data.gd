class_name ItemData extends Resource


enum Type {
	JAJO,
	CUKIER,
	BROKUL,
	MISC,
	READY,
	POMIDOR,
	OMLET_RAW,
}


@export var type: Type = Type.MISC
@export var sprite: Texture2D
@export var icon: Texture2D
@export var can_be_cut: bool = false
@export var item_after_cutting: ItemData
@export var can_be_cooked: bool = false
@export var plate_sprite: Texture2D
