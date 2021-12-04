tool
extends Area2D

export var whichLevel : = 0

export var next_scene: PackedScene

func _on_Portal_body_entered( body : PhysicsBody2D ) -> void :
  if ( whichLevel == 2|| whichLevel == 5 || whichLevel == 7):
    print("Player entered room 3")
    
    body.position = Vector2(2080, -320)
    print(body.position) 
  elif (whichLevel == 1):
    print("player entered room 1")
  elif (whichLevel == 0 || whichLevel == 3):
    print(" Player entered room 2")
  elif (whichLevel == 6):
    print("player entered room 4")
  elif ( whichLevel == 4):
    print("player entered boss room")
  print("player position before portal ", body.get_global_position())  

  body.gotoLevel( whichLevel + 1 )
  
  print("player position after portal ", body.get_global_position())

func _on_body_entered(body: PhysicsBody2D):
  teleport()
  
func teleport() -> void:
  get_tree().change_scene_to(next_scene)
  if get_tree().root.get_node("Graveyard_Level").get_node("Player").in_graveyard == true:
    
    print("look at here ",get_tree().root.get_node("Graveyard_Level").get_node("Player"))
    get_tree().root.get_node("Castle_Level").get_node("Player").in_graveyard = false
    get_tree().root.get_node("Castle_Level").get_node("Player").in_castle = true
    
  

