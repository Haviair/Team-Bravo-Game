extends KinematicBody2D

onready var shootcooldownTimer = $ShootingCooldownTimer

onready var idleTimer = $WalkTimer

var speed = 150
var velocity = Vector2.ZERO
var blast = preload("res://Scenes/MageBlast.tscn")
var health = 30
var danger_zone = false
var player: Node
var angle

func _ready() -> void:
  pass # Replace with function body.


func _physics_process(_delta):
  if danger_zone == true:
    $AnimatedSprite.play("Stand-Down")
    angle = get_angle_to(player.get_global_position())
    direction()
    velocity = move_and_slide(Vector2.ZERO)
    if shootcooldownTimer.is_stopped():
      fire()
      shootcooldownTimer.start()
  elif idleTimer.is_stopped():
    idle_walk()
    idleTimer.start()
  velocity = move_and_slide(velocity)

func hit():
  if health <= 0:
    queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
  if body.get_name() == 'Player':
    player = body
    danger_zone = true 
    #shootcooldownTimer.start()

func fire():
  var blast_instance = blast.instance()
  blast_instance.position = get_global_position()
  blast_instance.gravity_scale = 0.0
  blast_instance.rotation = get_angle_to(player.get_global_position())
  get_tree().get_root().call_deferred("add_child", blast_instance)


func _on_Area2D_body_exited(body: Node) -> void:
  if body.get_name() == 'Player':
    player = null
    danger_zone = false

func idle_walk():
    velocity = Vector2.ZERO
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var my_random_number = rng.randi_range(1, 5)
    
    if my_random_number == 1:
      velocity.x += 1
      $AnimatedSprite.play("Walk-Right")
    elif my_random_number == 2:
      velocity.x -= 1
      $AnimatedSprite.play("Walk-Left")
    elif my_random_number == 3:
      velocity.y += 1
      $AnimatedSprite.play("Walk-Down")
    elif my_random_number == 4:
      velocity.y -= 1
      $AnimatedSprite.play("Walk-Up")
    elif my_random_number == 5:
      velocity.y = 0
      velocity.x = 0
      $AnimatedSprite.play("Stand-Down")
    velocity = velocity.normalized() * speed
    
func direction():
#  if angle > (3*PI/4) and (-3*PI/4) > angle:
#    $AnimatedSprite.play("Stand-Left")
#    print("facing left")
  if (-PI/4) < angle and angle < (PI/4):
    $AnimatedSprite.play("Stand-Right")
#    print("facing right")
  elif (PI/4) < angle and angle < (3*PI/4):
    $AnimatedSprite.play("Stand-Down")
#    print("facing down")
  elif (-3*PI/4) < angle and angle < (-PI/4):
    $AnimatedSprite.play("Stand-Up")
#    print("facing Up")
  else:
    $AnimatedSprite.play("Stand-Left")
#    print("facing left")
