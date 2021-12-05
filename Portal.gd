extends Area2D

export var whichLevel : = 0

func _on_Portal_body_entered( body : PhysicsBody2D ) -> void :
  print( "Player entered the Portal for level %d." % [ whichLevel ] )

  body.gotoLevel( whichLevel + 1 )
