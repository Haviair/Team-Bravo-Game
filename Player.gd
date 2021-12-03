extends KinematicBody2D

onready var shootcooldownTimer = $ShootingCooldownTimer
onready var damagetimer = $DamageTimer
onready var en_dmg_timer = $EnemyTimer

var speed = 500
var arrow_speed = 1000
var arrow = preload("res://Arrow.tscn")
var velocity = Vector2()
var direction = Vector2.DOWN
var direction_radians = PI/2
var hp = 100

var multishot = false
var diagonalshot = false
var arrow_dmg = 10

var in_graveyard = true
var in_castle = false
var in_field = false

const graveyard_level = [
  { 'StartPosition' : Vector2(  200, 240 ), 'CameraLimits' : [  0, 1280, 0, 800 ] },
  { 'StartPosition' : Vector2( 1600, 400 ), 'CameraLimits' : [ 1560, 2720, 0, 800 ] },
  { 'StartPosition' : Vector2( 1120, 400 ), 'CameraLimits' : [ 0, 1280, 0, 800 ] },
  { 'StartPosition' : Vector2( -320, 400 ), 'CameraLimits' : [ -2080, -160, -720, 1440 ] },
  { 'StartPosition' : Vector2( 160, 400 ), 'CameraLimits' : [ 0, 1280, 0, 800 ] },
  { 'StartPosition' : Vector2( 640, -320 ), 'CameraLimits' : [ 0, 1280, -960, -160 ] },
  { 'StartPosition' : Vector2( 640, 160 ), 'CameraLimits' : [ 0, 1280, 0, 800 ] },
  { 'StartPosition' : Vector2( 640, 1120 ), 'CameraLimits' : [ 0, 1280, 960, 1680 ] },
  { 'StartPosition' : Vector2( 640, 640 ), 'CameraLimits' : [ 0, 1280, 0, 800 ] }
  ]

const castle_level = [
  { 'StartPosition' : Vector2(  160, 320 ), 'CameraLimits' : [  0, 1280, 0, 800 ] },
  { 'StartPosition' : Vector2( 1600, 400 ), 'CameraLimits' : [ 1560, 2720, 0, 800 ] },
  { 'StartPosition' : Vector2( 2080, 40 ), 'CameraLimits' : [ -960, -240, 1436, 2724 ] }
  ]

var currentLevel : = 0

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
    $AudioStreamPlayer.stream = preload("res://Music/shoot.ogg")
    $AudioStreamPlayer.play()
    fire()
    if (diagonalshot == true):
      diagnol_right_fire()
      diagnol_left_fire()
    if (multishot == true):
      yield(get_tree().create_timer(0.15), "timeout")
      fire()
      if (diagonalshot == true):
        diagnol_right_fire()
        diagnol_left_fire()
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
    $AudioStreamPlayer.stream = preload("res://Music/player_grunt.wav")
    $AudioStreamPlayer.play()
    hp -= 25
    get_tree().root.get_node("Graveyard_Level").get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = hp

  #Check if player has health left or not
  if hp <= 0:
    #TODO: killing player currently crashes game because of UI
    #TODO: Instead of freeing player node, make a pop up screen 
    queue_free()

  if Input.is_action_just_pressed("ui_cancel"):
    get_tree().quit( 0 )
    
  if hp == 0: 
    $AudioStreamPlayer.stream = preload("res://Music/player_grunt.wav")
    $AudioStreamPlayer.play()
    queue_free()

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
  
  
func diagnol_right_fire():
  var arrow_instance = arrow.instance()
  arrow_instance.position = get_global_position()
  #arrow_instance.rotate(PI/4)
  arrow_instance.gravity_scale = 0.0
  match direction_radians:
    (PI/2):
      arrow_instance.rotate(PI/4)
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,700))
    ((3*PI)/2):
      arrow_instance.rotate(5*PI/4)
      arrow_instance.apply_central_impulse(Vector2(-arrow_speed,-700))
    0:
      arrow_instance.rotate(PI/4)
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,700))
    PI:
      arrow_instance.rotate(5*PI/4)
      arrow_instance.apply_central_impulse(Vector2(-arrow_speed,-700))
  get_tree().get_root().call_deferred("add_child", arrow_instance)
  
func diagnol_left_fire():
  var arrow_instance = arrow.instance()
  arrow_instance.position = get_global_position()
  arrow_instance.gravity_scale = 0.0
  match direction_radians:
    (PI/2):
      arrow_instance.rotate(3*PI/4)
      arrow_instance.apply_central_impulse(Vector2(-arrow_speed,700))
    ((3*PI)/2):
      arrow_instance.rotate(7*PI/4)
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,-700))
    0:
      arrow_instance.rotate(7*PI/4)
      arrow_instance.apply_central_impulse(Vector2(arrow_speed,-700))
    PI:
      arrow_instance.rotate(3*PI/4)
      arrow_instance.apply_central_impulse(Vector2(-arrow_speed,700))
  get_tree().get_root().call_deferred("add_child", arrow_instance)
  
func _enemy_body_entered(body: Node):
  if 'Enemy' in body.get_name():
    hp -= 25
    $AudioStreamPlayer.stream = preload("res://Music/player_grunt.wav")
    $AudioStreamPlayer.play()
    get_tree().root.get_node("Graveyard_Level").get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = hp
    damagetimer.start()
  elif 'Boss' in body.get_name():
    hp -= 25
    en_dmg_timer.start()
  elif 'Orb' in body.get_name():
    body.remove()
    hp -= 25
    get_tree().root.get_node("Graveyard_Level").get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = hp
    
func _enemy_body_exited(body: Node):
  if 'Enemy' in body.get_name():
    damagetimer.stop()
  elif 'Boss' in body.get_name():
     en_dmg_timer.stop()
    
func _on_damage_timer_timeout():
  hp -= 25
  $AudioStreamPlayer.stream = preload("res://Music/player_grunt.wav")
  $AudioStreamPlayer.play()
  get_tree().root.get_node("Graveyard_Level").get_node("CanvasLayer2").get_node("Player_UI").get_node("Healthbar").value = hp

func gotoLevel( which : int = -1 ) -> void :
  if in_graveyard == true:
    if which < 0 :
      which = currentLevel

    if which >= graveyard_level.size() :
      print( "Finished last level, so going back to the beginning." )
      which = 0

    position = graveyard_level[which][ 'StartPosition' ]
    $Camera2D.limit_left  = graveyard_level[which][ 'CameraLimits' ][0]
    $Camera2D.limit_right = graveyard_level[which][ 'CameraLimits' ][1]
    $Camera2D.limit_top = graveyard_level[which][ 'CameraLimits' ][2]
    $Camera2D.limit_bottom = graveyard_level[which][ 'CameraLimits' ][3]
  
  elif in_castle == true:
    if which < 0 :
      which = currentLevel

    if which >= castle_level.size() :
      print( "Finished last level, so going back to the beginning." )
      which = 0

    position = castle_level[which][ 'StartPosition' ]
    $Camera2D.limit_left  = castle_level[which][ 'CameraLimits' ][0]
    $Camera2D.limit_right = castle_level[which][ 'CameraLimits' ][1]
    $Camera2D.limit_top = castle_level[which][ 'CameraLimits' ][2]
    $Camera2D.limit_bottom = castle_level[which][ 'CameraLimits' ][3]
  
func increase_dmg():
  arrow_dmg += 10

