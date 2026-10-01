extends State


# untuk sementa4ra, jika game over maka ulangi scene aja
func enter()->void:
	get_tree().reload_current_scene()
