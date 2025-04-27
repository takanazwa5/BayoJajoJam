class_name Kura extends Button


var playing: bool = false


@onready var sfx: Array[AudioStreamPlayer]


func _ready() -> void:

	for child : Node in get_children():

		if child is AudioStreamPlayer:

			sfx.append(child)
			child.finished.connect(_on_audio_finished)

	pressed.connect(_on_pressed)


func _on_pressed() -> void:

	if not playing:

		sfx.pick_random().play()
		playing = true


func _on_audio_finished() -> void:

	playing = false
