extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
  if "Enemy" in body.get_name():
    body.health -=   get_tree().root.get_node("Graveyard_Level").get_node("Player").arrow_dmg
    body.hit()
  elif "Boss" in body.get_name():
    body.hit()
  #print(body.get_name())
  queue_free()
