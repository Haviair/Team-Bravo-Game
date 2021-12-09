extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass


func _on_Diagnolshoot_body_entered(body: Node) -> void:
  var cur_lvl = get_tree().get_current_scene().get_name()
  get_tree().root.get_node(cur_lvl).get_node("Player").diagonalshot = true
  queue_free()
