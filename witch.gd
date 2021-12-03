extends KinematicBody2D

var hp = 100
var run_speed = 350
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
    
