#https://9e0.itch.io/witches-pack
extends KinematicBody2D

onready var shoot_tmr = $orb_shooting_timer
var hp = 100
var run_speed = 200
var orb = preload("res://Scenes/orb.tscn")
var player: Node
var follow_act = false
var patrol_act = true

var ready_to_talk = true
var Witch_Dialogue = preload("res://Scenes/Textbox.tscn")

func _ready():
    $AnimatedSprite.play("idle")

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
    position = Vector2(  3800, 700 )

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
    patrol_act = false
    $AnimatedSprite.play("run")
      
func _on_Follow_Detection_body_exited(body):
  #Check if player, might also be arrow
  if body.get_name() == 'Player':
    player = null
    follow_act = false
    patrol_act = true
    $AnimatedSprite.play("idle")

func _on_Orb_Zone_body_entered(body):
  if body.get_name() == 'Player':
    #Stop following
    $AnimatedSprite.play("charge")
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
    $AnimatedSprite.play("run")
    shoot_tmr.stop()
    
func fire_orb():
  #Called when witch comes within orb distance of player and from timer
  var orb_instance = orb.instance()
  var player_pos : Vector2
  orb_instance.position = get_global_position()
  orb_instance.gravity_scale = 0.0
  player_pos = self.position.direction_to(player.position)*100
  orb_instance.apply_central_impulse(player_pos)
  get_tree().get_root().call_deferred("add_child", orb_instance)


func _on_Area2D_body_entered(body: Node) -> void:
  if body.get_name() == 'Player':
    if ready_to_talk == true:
      var Witch_Talk = Witch_Dialogue.instance()
      get_tree().get_root().call_deferred("add_child", Witch_Talk)
