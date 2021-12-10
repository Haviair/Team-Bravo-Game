extends Node

func _ready() -> void:
    get_tree().root.get_node("Openfield_Level/Player").in_field = true
    get_tree().root.get_node("Openfield_Level/Player").in_graveyard = false
    get_tree().root.get_node("Openfield_Level/Player").in_castle = false
    get_tree().root.get_node("Openfield_Level/Player").cur_lvl = "Openfield_Level"
    get_tree().root.get_node("Openfield_Level/Chest").cur_lvl = "Openfield_Level"
    if $AudioStreamPlayer.playing == false :
      $AudioStreamPlayer.play()
