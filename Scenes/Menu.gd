extends Button




export(String, FILE) var next_scene_path: = ""




func _on_Menu_pressed() -> void:
  
  get_tree().change_scene(next_scene_path)
