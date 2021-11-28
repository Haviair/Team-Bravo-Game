extends Node

func _ready() -> void:
  if $AudioStreamPlayer.playing == false :
    $AudioStreamPlayer.play()

