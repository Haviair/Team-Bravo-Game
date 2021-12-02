extends KinematicBody2D

var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("idle")


func hit():
  #Called from arrow.gd when collision occurs with enemy
  hp -= 25
  if hp == 0:
    $AnimatedSprite.play("death")
    yield($AnimatedSprite, "animation_finished")
    queue_free()
