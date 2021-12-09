extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
  #When arrow hits an enemy, modifies enemy hp
  var cur_lvl = get_tree().get_current_scene().get_name()
  if "Enemy" in body.get_name():
    body.health -=   get_tree().root.get_node(cur_lvl).get_node("Player").arrow_dmg
    body.hit()
  elif "Boss" in body.get_name():
    body.health -=   get_tree().root.get_node(cur_lvl).get_node("Player").arrow_dmg
    body.hit()
  elif "Witch" in body.get_name() or "monster" in body.get_name():
    body.health -=   get_tree().root.get_node(cur_lvl).get_node("Player").arrow_dmg
    body.hit()
  queue_free()
