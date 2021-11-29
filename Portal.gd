tool
extends Area2D

export var whichLevel : = 0

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

func _on_Portal_body_entered( body : PhysicsBody2D ) -> void :
  print( "Player entered the Portal for level %d." % [ whichLevel ] )

  body.gotoLevel( whichLevel + 1 )
  
  
func _on_body_entered(body: PhysicsBody2D):
  teleport()
  
func teleport() -> void:
  if get_tree().root.get_node("Graveyard_Level").get_node("Player").in_graveyard == true:
    get_tree().root.get_node("Graveyard_Level").get_node("Player").in_graveyard = false
    get_tree().root.get_node("Graveyard_Level").get_node("Player").in_castle = true
  get_tree().change_scene_to(next_scene)
  

