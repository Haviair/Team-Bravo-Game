extends Button
#
#func _on_retry_pressed() -> void:


export(String, FILE) var next_scene_path: = ""



func _on_retry_button_up() -> void:
  
  get_tree().change_scene(next_scene_path)
