class_name MalaKura extends Button


var playing: bool = false
var sfx: Array[AudioStreamPlayer]


func _ready() -> void:

	for node : Node in get_tree().get_nodes_in_group(&"SFX"):

		if node is AudioStreamPlayer:

			sfx.append(node)
			node.finished.connect(_on_audio_finished)

	pressed.connect(_on_pressed)


func _on_pressed() -> void:

	if not playing:

		sfx.pick_random().play()
		playing = true


func _on_audio_finished() -> void:

	playing = false
