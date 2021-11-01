extends Area2D


func _on_Health_body_entered(body: Node) -> void:
  if get_tree().root.get_node("Graveyard_Level").get_node("Player").hp < 100:
    get_tree().root.get_node("Graveyard_Level").get_node("Player").hp += 25
    if get_tree().root.get_node("Graveyard_Level").get_node("Player").hp > 100:
      get_tree().root.get_node("Graveyard_Level").get_node("Player").hp = 100
  print(get_tree().root.get_node("Graveyard_Level").get_node("Player").hp)
  queue_free()
  
