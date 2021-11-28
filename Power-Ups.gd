extends Node

var powerups = ["Health", "Multishot", "Diagonal Arrows", "Damage Up"]
var size = powerups.size()
  

func powerup_selection():
  var size = powerups.size()
  var rng = RandomNumberGenerator.new()
  rng.randomize()
  var my_random_number = rng.randi_range(1, size);
  
  if my_random_number-1 == -1: return
  
  elif (size == 0): return 
    
  elif (powerups[my_random_number-1] == "Health"):
    powerups.remove(my_random_number-1)
    return "Health"
  
  elif (powerups[my_random_number-1] == "Multishot"):
    powerups.remove(my_random_number-1)
    return "Multishot"
  
  elif (powerups[my_random_number-1] == "Diagonal Arrows"):
    powerups.remove(my_random_number-1)
    return "Diagonal Arrows"

  elif (powerups[my_random_number-1] == "Damage Up"):
    powerups.remove(my_random_number-1)
    return "Damage Up"
