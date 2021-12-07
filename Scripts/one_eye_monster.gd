extends KinematicBody2D

onready var shoot_tmr = $shooting_timer
var hp = 100
var run_speed = 200
var orb = preload("res://projectile.tscn")
var player: Node
var follow_act = false
var patrol_act = true

func _physics_process(_delta):
  var enemy_pos: Vector2
  #If player is inside Area2D then follow using vector kinematics
  if follow_act and player:
    enemy_pos = self.position.direction_to(player.position)*run_speed
    enemy_pos = move_and_slide(enemy_pos)
  elif patrol_act:
    #Implement patrol here
    #How to implement: Go back to home base
    #Makes more sense for main boss to go back to a home base since the player has to beat the boss
    pass

func hit():
  #Called from arrow.gd when collision occurs with enemy
  hp -= 25
  if hp == 0:
    queue_free()
    
func _on_Follow_Detection_body_entered(body):
  if body.get_name() == 'Player':
    player = body
    follow_act = true
    patrol_act = false
      
func _on_Follow_Detection_body_exited(body):
  #Check if player, might also be arrow
  if body.get_name() == 'Player':
    player = null
    follow_act = false
    patrol_act = true

func _on_Orb_Zone_body_entered(body):
  if body.get_name() == 'Player':
    #Stop following
    follow_act = false
    patrol_act = false
    #Fire an orb and start timer
    fire_orb()
    shoot_tmr.start()
    
func _on_Orb_Zone_body_exited(body):
  if body.get_name() == 'Player':
    #stop timer
    follow_act = true
    patrol_act = false
    shoot_tmr.stop()
    
func fire_orb():
  #Called when witch comes within orb distance of player and from timer
  var orb_instance = orb.instance()
  var player_pos : Vector2
  orb_instance.position = get_global_position()
  orb_instance.gravity_scale = 0.0
  player_pos = self.position.direction_to(player.position)*100
  orb_instance.apply_central_impulse(player_pos)
  orb_instance.apply_anim()
  get_tree().get_root().call_deferred("add_child", orb_instance)
