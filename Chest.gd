extends Area2D

var health = preload("res://Health.tscn")
var multi = preload("res://Multi-shoot.tscn")
var diagnol = preload("res://Diagnol-shoot.tscn")
var dmgup = preload("res://Dmg_Up.tscn")
var not_empty = true

func _ready() -> void:
  pass # Replace with function body.
  

func _on_Chest_body_entered(body) -> void:
  if(not_empty == true):
    var item_selected = get_tree().root.get_node("Graveyard_Level").get_node("Power-Ups").powerup_selection()
    if ( item_selected == "Health"):
      var health_instance = health.instance()
      health_instance.position = get_global_position()
      health_instance.position.x += 70
      get_tree().get_root().call_deferred("add_child", health_instance)
  
    elif (item_selected == "Multishot"):
      var multi_instance = multi.instance()
      multi_instance.position = get_global_position()
      multi_instance.position.x += 70
      get_tree().get_root().call_deferred("add_child", multi_instance)
  
    elif (item_selected == "Diagonal Arrows"):
      var diagnol_instance = diagnol.instance()
      diagnol_instance.position = get_global_position()
      diagnol_instance.position.x += 70
      get_tree().get_root().call_deferred("add_child", diagnol_instance)
  
    elif (item_selected == "Damage Up"):
      var dmgup_instance = dmgup.instance()
      dmgup_instance.position = get_global_position()
      dmgup_instance.position.x += 70
      get_tree().get_root().call_deferred("add_child", dmgup_instance)
      
    $AnimatedSprite.play("Opened")
    not_empty = true
  else:
    pass
