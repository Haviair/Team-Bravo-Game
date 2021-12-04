extends KinematicBody2D

onready var shoot_tmr = $orb_shooting_timer
var hp = 100
var run_speed = 200
var orb = preload("res://orb.tscn")
var player: Node
var follow_act = false
# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("idle")

func _physics_process(_delta):
  var enemy_pos: Vector2
  #If player is inside Area2D then follow using vector kinematics
  if follow_act:
    enemy_pos = self.position.direction_to(player.position)*run_speed
    enemy_pos = move_and_slide(enemy_pos)

func hit():
  #Called from arrow.gd when collision occurs with enemy
  hp -= 25
  $AnimatedSprite.play("damage")
  if hp == 0:
    $AnimatedSprite.play("death")
    yield($AnimatedSprite, "animation_finished")
    queue_free()
  yield($AnimatedSprite, "animation_finished")
  $AnimatedSprite.play("idle")
  
    
func _on_Follow_Detection_body_entered(body):
  if body.get_name() == 'Player':
    player = body
    follow_act = true
    $AnimatedSprite.play("run")
      
func _on_Follow_Detection_body_exited(body):
  #Check if player, might also be arrow
  if body.get_name() == 'Player':
    player = null
    follow_act = false
    $AnimatedSprite.play("idle")

func _on_Orb_Zone_body_entered(body):
  if body.get_name() == 'Player':
    #Stop following
    $AnimatedSprite.play("charge")
    follow_act = false
    #Fire an orb and start timer
    fire_orb()
    shoot_tmr.start()
    
func _on_Orb_Zone_body_exited(body):
  if body.get_name() == 'Player':
    #stop timer
    $AnimatedSprite.play("run")
    shoot_tmr.stop()
    
func fire_orb():
  #Called when witch comes within orb distance of player and from timer
  var orb_instance = orb.instance()
  var player_pos : Vector2
  orb_instance.position = get_global_position()
  orb_instance.gravity_scale = 0.0
  player_pos = self.position.direction_to(player.position)*100
  print(player_pos)
  orb_instance.apply_central_impulse(player_pos)
  get_tree().get_root().call_deferred("add_child", orb_instance)
