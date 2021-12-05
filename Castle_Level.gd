extends Node

func _ready() -> void:
    get_tree().root.get_node("Castle_Level").get_node("Player").in_graveyard = false
    get_tree().root.get_node("Castle_Level").get_node("Player").in_castle = true
