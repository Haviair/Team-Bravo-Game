extends RigidBody2D

var blast_speed = 600
var blast_dmg = 10

func _ready() -> void:
  apply_impulse(Vector2(), Vector2(blast_speed, 0).rotated(rotation))

func _on_Area2D_body_entered(body: Node) -> void:
  if "Player" in body.get_name():
    body.hp -= blast_dmg
    get_tree().root.get_node("Graveyard_Level").get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = body.hp
  queue_free()
