extends KinematicBody2D

onready var attackTimer = $Attack_Timer

onready var idleTimer = $Walk_Timer

var speed = 1000
var walk_speed = 150
var velocity = Vector2.ZERO
var blast = preload("res://Scenes/MageBlast.tscn")
var health = 30
var danger_zone = false
var player: Node
var enemy_pos: Vector2

func _ready() -> void:
  pass # Replace with function body.


func _physics_process(_delta):
  if danger_zone == true:
    if attackTimer.is_stopped():
      $AnimatedSprite.play("Run")
      enemy_pos = move_and_slide(enemy_pos)
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
    pounce()

func pounce():
  if player != null:
    look_at(player.get_global_position())
    enemy_pos = self.position.direction_to(player.position)*speed
  velocity = move_and_slide(Vector2.ZERO)
  $AnimatedSprite.play("Pounce")
  attackTimer.start()
  


func _on_Area2D_body_exited(body: Node) -> void:
  if body.get_name() == 'Player':
    player = null
    danger_zone = false
    $AnimatedSprite.play("Stand")

func idle_walk():
    velocity = Vector2.ZERO
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var my_random_number = rng.randi_range(1, 5)
    
    if my_random_number == 1:
      velocity.x += 1
      $AnimatedSprite.play("Walk") #right
      self.position.direction_to(Vector2.RIGHT)
      look_at(self.get_global_position() + Vector2(1, 0))
    elif my_random_number == 2:
      velocity.x -= 1
      $AnimatedSprite.play("Walk") #left
      self.position.direction_to(Vector2.LEFT)
      look_at(self.get_global_position() + Vector2(-1, 0))
    elif my_random_number == 3:
      velocity.y += 1
      $AnimatedSprite.play("Walk") #down
      self.position.direction_to(Vector2.DOWN)
      look_at(self.get_global_position() + Vector2(0, 1))
    elif my_random_number == 4:
      velocity.y -= 1
      $AnimatedSprite.play("Walk") #up
      self.position.direction_to(Vector2.UP)
      look_at(self.get_global_position() + Vector2(0, -1))
    elif my_random_number == 5:
      velocity.y = 0
      velocity.x = 0
      $AnimatedSprite.play("Stand") #nothing
      self.position.direction_to(Vector2.DOWN)
    velocity = velocity.normalized() * walk_speed
    

func _on_Against_body_entered(body: Node) -> void:
  if body.get_name() == "Map Layout" and player == null:
    idle_walk()
  elif body.get_name() == "Map Layout" and player != null:
    pounce()
  elif body.get_name() == "Player":
    pounce()
