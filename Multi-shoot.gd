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


func _on_Multishoot_body_entered(body: Node) -> void:
  get_tree().root.get_node("Graveyard_Level").get_node("Player").multishot = true
  queue_free()
