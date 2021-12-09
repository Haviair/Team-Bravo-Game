extends KinematicBody2D

var Old_Man_Dialogue = preload("res://Scenes/Textbox.tscn")
var Old_Man_Dialogue2 = preload("res://Scenes/Textbox.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var old_man_lv1 = false
var old_man_lv2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  #if get_tree().root == "Graveyard_Level.tscn"
  pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#  pass


func _on_Area2D_body_entered(body: Node) -> void:
  if body.get_name() == 'Player':
    if get_parent().name == "Graveyard_Level":
      old_man_lv1 = true
      #var Old_Man_Talk = Old_Man_Dialogue.instance()
      #get_tree().get_root().call_deferred("add_child", Old_Man_Talk)
    if get_parent().name == "Castle_Level":
      old_man_lv2 = true
      #var Old_Man_Talk2 = Old_Man_Dialogue2.instance()
      #get_tree().get_root().call_deferred("add_child", Old_Man_Talk2)
