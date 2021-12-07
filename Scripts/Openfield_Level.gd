extends Node

func _ready() -> void:
    print("I am the new Root: Openfield")
    get_tree().root.get_node("Openfield_Level").get_node("Player").in_field = true
    get_tree().root.get_node("Openfield_Level").get_node("Player").in_graveyard = false
    get_tree().root.get_node("Openfield_Level").get_node("Player").in_castle = false
