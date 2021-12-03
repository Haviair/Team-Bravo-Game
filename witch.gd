extends KinematicBody2D

onready var shoot_tmr = $orb_shooting_timer
var hp = 100
var run_speed = 200
var orb = preload("res://orb.tscn")
var player: Node

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("idle")

func _physics_process(_delta):
  var enemy_pos: Vector2
  #If player is inside Area2D then follow using vector kinematics
  if player:
    enemy_pos = self.position.direction_to(player.position)*run_speed
    enemy_pos = move_and_slide(enemy_pos)

func hit():
  #Called from arrow.gd when collision occurs with enemy
  hp -= 25
  if hp == 0:
    $AnimatedSprite.play("death")
    yield($AnimatedSprite, "animation_finished")
    queue_free()
    
func _on_Follow_Detection_body_entered(body):
  if body.get_name() == 'Player':
    player = body
      
func _on_Follow_Detection_body_exited(body):
  #Check if player, might also be arrow
  if body.get_name() == 'Player':
    player = null

func _on_Orb_Zone_body_entered(body):
  if body.get_name() == 'Player':
    #Stop following
    player = null
    #Fire an orb and start timer
    fire_orb()
    shoot_tmr.start()
    
func _on_Orb_Zone_body_exited(body):
  if body.get_name() == 'Player':
    #stop timer
    shoot_tmr.stop()
    
func fire_orb():
  #Called when witch comes within orb distance of player and from timer
  var orb_instance = orb.instance()
  
