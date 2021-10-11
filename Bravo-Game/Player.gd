extends KinematicBody2D

var speed = 500
var arrow_speed = 1000
var arrow = preload("res://Arrow.tscn")
var velocity = Vector2()
var direction = Vector2.DOWN
var direction_radians = PI/2

func get_input():
  velocity = Vector2()
  if Input.is_action_pressed("right"):
    velocity.x += 1
    direction = Vector2.RIGHT
    direction_radians = 0
  if Input.is_action_pressed("left"):
    velocity.x -= 1
    direction = Vector2.LEFT
    direction_radians = PI
  if Input.is_action_pressed("down"):
    velocity.y += 1
    direction = Vector2.DOWN
    direction_radians = PI/2
  if Input.is_action_pressed("up"):
    velocity.y -= 1
    direction = Vector2.UP
    direction_radians = (3*PI)/2
  velocity = velocity.normalized() * speed

  if Input.is_action_just_pressed("shoot"):
    fire()

func _physics_process(delta):
  get_input()
  velocity = move_and_slide(velocity)

func fire():
  var arrow_instance = arrow.instance()
  arrow_instance.position = get_global_position()
  arrow_instance.rotate(direction_radians)
  arrow_instance.gravity_scale = 0.0
#  arrow_instance.apply_impulse(Vector2(), Vector2(arrow_speed,0))
#  print(direction_radians)
#  print(direction)

#  if  direction_radians == (PI/2) || ((3*PI)/2):
#    print ("Made it 2")
#    arrow_instance.apply_central_impulse(Vector2(0,arrow_speed)*direction)
#  elif direction_radians == 0 || PI :
#    print ("Made it 1")
#    arrow_instance.apply_central_impulse(Vector2(arrow_speed,0)*direction)
  
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



