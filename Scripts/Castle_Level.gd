extends Node

func _ready() -> void:
    get_tree().root.get_node("Castle_Level/Player").in_graveyard = false
    get_tree().root.get_node("Castle_Level/Player").in_castle = true
    get_tree().root.get_node("Castle_Level/Player").in_field = false
    get_tree().root.get_node("Castle_Level/Player").cur_lvl = "Castle_Level"
    get_tree().root.get_node("Castle_Level/Chest").cur_lvl = "Castle_Level"
    if $AudioStreamPlayer.playing == false :
      $AudioStreamPlayer.play()
