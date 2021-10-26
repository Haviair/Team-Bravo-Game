extends Area2D

# Which level am I the portal for?
export var whichLevel : = 0

func _on_Portal1_body_entered(body: PhysicsBody2D) -> void:
  print( "Player entered the Portal for level %d." % [ whichLevel ] )

  # When the portal on a level is entered by the player, we tell
  #   the player to go to the next level, which is our level
  #   number plus 1.
  body.gotoLevel( whichLevel + 1 )
