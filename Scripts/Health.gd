extends Area2D


func _on_Health_body_entered(body: Node) -> void:
  var cur_lvl = get_tree().get_current_scene().get_name()
  if get_tree().root.get_node(cur_lvl).get_node("Player").hp < 100:
    get_tree().root.get_node(cur_lvl).get_node("Player").hp += 25
    if get_tree().root.get_node(cur_lvl).get_node("Player").hp > 100:
      get_tree().root.get_node(cur_lvl).get_node("Player").hp = 100
  get_tree().root.get_node(cur_lvl).get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = get_tree().root.get_node(cur_lvl).get_node("Player").hp
  queue_free()
  
