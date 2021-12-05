extends Area2D

export var whichLevel : = 0

func _on_Portal_body_entered( body : PhysicsBody2D ) -> void :
  body.gotoLevel( whichLevel + 1 )
