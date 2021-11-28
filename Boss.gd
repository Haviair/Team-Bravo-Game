extends KinematicBody2D

var enemy_pos: Vector2
var run_speed = 350
var player: Node

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
  #If player is inside Area2D then follow using vector kinematics
  if player:
    enemy_pos = self.position.direction_to(player.position)*run_speed
    enemy_pos = move_and_slide(enemy_pos)
  
func hit():
  #Called from arrow.gd when collision occurs with enemy
  queue_free()

func _on_Detection_Zone_body_entered(body):
    if body.get_name() == 'Player':
      player = body

func _on_Detection_Zone_body_exited(body):
  #Check if player, might also be arrow
 if body.get_name() == 'Player':
    player = null
