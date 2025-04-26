class_name ItemData extends Resource


enum Type {
	JAJO,
	CUKIER,
	BROKUL,
	MISC,
	READY,
}


@export var type: Type = Type.MISC
@export var sprite: Texture2D
@export var icon: Texture2D
@export var can_be_cut: bool = false
@export var item_after_cutting: ItemData
