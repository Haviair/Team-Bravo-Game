extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
  queue_free()
