extends Area2D

var health = preload("res://Health.tscn")
var not_empty = true

func _ready() -> void:
  pass # Replace with function body.
  

func _on_Chest_body_entered(body) -> void:
  if(not_empty == true):
    var powerups = ["Health"]
    var size = powerups.size()
    var rng = RandomNumberGenerator.new()
  
    rng.randomize()
    var my_random_number = rng.randi_range(1, size);

  
    if (powerups[my_random_number-1] == "Health"):
      var health_instance = health.instance()
      health_instance.position = get_global_position()
      health_instance.position.x += 70
      get_tree().get_root().call_deferred("add_child", health_instance)
  
    $AnimatedSprite.play("Opened")
    not_empty = false
  
  else:
    pass
