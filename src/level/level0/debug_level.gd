extends Node2D
const BOS_ROOM = preload("res://src/level/level0/bos_room.tscn")

func _on_finished_body_entered(body: Node2D) -> void:

	if body is Player :
		get_tree().change_scene_to_packed(BOS_ROOM)
