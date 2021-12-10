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
  print("Starting state: State.READY")
  hide_textbox()
  queue_text("Upon successfully completing the mission tasked to him, the archer returns to the kingdom. Here he is met with yet another task, with not much time to rest. Such is the life of our hero.")
  queue_text("The hero is informed that, while he was away, there have been some significant developments in the castle of Lahin. The castle of Lahin belongs to the old duke K S Lahin.")
  queue_text("The duke, after much turmoil and ill affair, has finally gone crazy in his old age. What is going through his mind, no one can tell.")
  queue_text("But we can be sure of one thing, he has taken his maidservants hostage in his own home, after locking them in for several weeks. ")
  queue_text("Friends and strangers alike tried to reason with him, none were granted an audience in his castle nor were their words heeded")
  queue_text("The duke must be stopped and his hostages must be freed before harm comes their way. This is the immediate task of the hero now. After a few minutes of getting his bearings in place, he makes his way to Castle Lahin.")
  queue_text("Lahin: 'HALT. WHO GOES THERE'. Hero: ' I am here to put an end to this madness. Release your servants at once!' Lahin: ' AHAHAHAHAHAH. YOU THINK U CAN STOP ME?!?! I Will sacrifice them to the powers of evil and gain their favor. ehehehe' Hero: ' I can and I will! Let me in and I'll show you TRUE power..!' Lahin: 'We'll see what power you can put on display! Mehehehe....' ")
  queue_text("Our Hero has no idea what kind of madness and foes he will encounter here. All he hopes to do is stop the duke and rescue those maidservants swiftly. ")
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
  match current_state:
    State.READY:
      print("Changing state to: State.READY")
    State.READING:
      print("Changing state to: State.READING")
    State.FINISHED:
      print("Changing state to: State.FINISHED")

func _on_Tween_tween_completed(object, key):
  change_state(State.FINISHED)
