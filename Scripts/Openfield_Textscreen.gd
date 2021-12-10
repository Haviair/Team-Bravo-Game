extends CanvasLayer

const CHAR_READ_RATE = 0.05

export var next_scene: PackedScene

onready var textscreen_container = $ScreenContainer
onready var label = $MarginContainer/Label

enum State {
  READY,
  READING,
  FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
  hide_textbox()
  
  queue_text("Our hero now finds himself in a meeting with an official of the kingdom.")
  queue_text("Official: I want to congratulate you on behalf of the kingdom. Your good deeds aren't going unnoticed.")
  queue_text("Hero: I'm honored. You did not need to come all the way here to tell me that though, really. Something tells me you're here to do more than give me a pat on the back. What's up? ")
  queue_text("Official: Sharp aren't you. Yes, I come with some information. For quite some time now, there has been an increased level of danger in the land just outside the kingdom.")
  queue_text("Official: At first we just played it off as wild animals and predators getting hungrier and more desperate, so we thought we'd just observe. With time, the aggression  has only increased.")
  queue_text("Official: There have been several cases of people gone missing in that area, mostly among the people that live on the border and outskirts near there.")
  queue_text("Hero: So what do u guys think is really going on..?")
  queue_text("Official: Nothing is 100% so far...we're accounting the behavior of the animals to some vengeful spirits upsetting the balance and making them go crazy. That's where you come in, actually...")
  queue_text("Official: We were hoping you could take a look yourself and see if you can find some evidence that points to some conclusion, or points in any plausible direction really...")
  queue_text("Hero: I will head out early tomorrow and resolve the issue")
  queue_text("")
  
func _process(delta):
  match current_state:
    State.READY:
      if !text_queue.empty():
        display_text()
    State.READING:
      if Input.is_action_just_pressed("ui_accept"):
        label.percent_visible = 1.0
        $Tween.remove_all()
        change_state(State.FINISHED)
    State.FINISHED:
      if Input.is_action_just_pressed("ui_accept"):
        change_state(State.READY)
        hide_textbox()
  if text_queue.empty() == true:
      get_tree().change_scene_to(next_scene)

func queue_text(next_text):
  text_queue.push_back(next_text)

func hide_textbox():
  label.text = ""
  textscreen_container.hide()

func show_textbox():
  textscreen_container.show()

func display_text():
  var next_text = text_queue.pop_front()
  label.text = next_text
  label.percent_visible = 0.0
  change_state(State.READING)
  show_textbox()
  $Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
  $Tween.start()

func change_state(next_state):
  current_state = next_state

func _on_Tween_tween_completed(object, key):
  change_state(State.FINISHED)
