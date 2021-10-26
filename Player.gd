extends KinematicBody2D

onready var shootcooldownTimer = $ShootingCooldownTimer

var speed = 500
var arrow_speed = 1000
var arrow = preload("res://Arrow.tscn")
var velocity = Vector2()
var direction = Vector2.DOWN
var direction_radians = PI/2
var hp = 100

func get_input():
  velocity = Vector2()
  if Input.is_action_pressed("right"):
    velocity.x += 1
    direction = Vector2.RIGHT
    #$AnimatedSprite.play("Archer_Run_Right")
    direction_radians = 0
  if Input.is_action_pressed("left"):
    velocity.x -= 1
    direction = Vector2.LEFT
    direction_radians = PI
    #$AnimatedSprite.play("Archer_Run_Left")
  if Input.is_action_pressed("down"):
    velocity.y += 1
    direction = Vector2.DOWN
    direction_radians = PI/2
  if Input.is_action_pressed("up"):
    velocity.y -= 1
    direction = Vector2.UP
    direction_radians = (3*PI)/2
  velocity = velocity.normalized() * speed

  if Input.is_action_just_pressed("shoot") and shootcooldownTimer.is_stopped():
    fire()
    #Multi-Shot start
    yield(get_tree().create_timer(0.15), "timeout")
    fire()
    #Multi-Shot end
    shootcooldownTimer.start()


func _physics_process(delta):
  get_input()
  velocity = move_and_slide(velocity)
  
  if Input.is_action_pressed("right"):
    $AnimatedSprite.set_flip_h(true)
    $AnimatedSprite.play("Run_Side")
  elif Input.is_action_pressed("left"):
    $AnimatedSprite.set_flip_h(false)
    $AnimatedSprite.play("Run_Side")
  elif Input.is_action_pressed("up"):
    $AnimatedSprite.play("Run_Up")
  elif Input.is_action_pressed("down"):
    $AnimatedSprite.play("Run_Down")
  elif direction == Vector2.RIGHT:
    $AnimatedSprite.play("Stand_Side")
  elif direction == Vector2.LEFT:
    $AnimatedSprite.play("Stand_Side")
  elif direction == Vector2.UP:
    $AnimatedSprite.play("Stand_Up")
  elif direction == Vector2.DOWN:
    $AnimatedSprite.play("Stand_Down")

  if Input.is_action_just_pressed("Hurtme"):
    hp -= 25

  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().quit( 0 )

func fire():
  var arrow_instance = arrow.instance()
  arrow_instance.position = get_global_position()
  arrow_instance.rotate(direction_radians)
  arrow_instance.gravity_scale = 0.0
  match direction_radians:
    (PI/2):
      arrow_instance.apply_central_impulse(Vector2(0,arrow_speed)*direction)
    ((3*PI)/2):
      arrow_instance.apply_central_impulse(Vector2(0,arrow_speed)*direction)
    0:
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,0)*direction)
    PI:
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,0)*direction)
  get_tree().get_root().call_deferred("add_child", arrow_instance)

const level = [
  { 'StartPosition' : Vector2(  192, 236 )},
  { 'StartPosition' : Vector2( 1775, 475 )}
  ]

var currentLevel : = 0

# Move the player (and camera) to the indicated level.
#   If the requested level is < 0, we just go to the start
#   position on the current leve.
#   If the requested level is greated than the number of levels,
#   we just go to the first level.
func gotoLevel( which : int = -1 ) -> void :
  if which < 0 :
    which = currentLevel

  if which >= level.size() :
    print( "Finished last level, so going back to the beginning." )
    which = 0

  # "Going to" a level means setting the Player to the start
  #   position on that level and setting the left and right limits
  #   of the camera view to the range that the level encompasses.
  position = level[which][ 'StartPosition' ]

