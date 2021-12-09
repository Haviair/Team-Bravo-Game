extends CanvasLayer

const CHAR_READ_RATE = 0.05

onready var textbox_container = $TextboxContainer
onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

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
  if get_parent().get_child(0).name == "Graveyard_Level":
    if get_tree().get_root().get_node("Graveyard_Level").get_node("Old_Man").old_man_lv1 == true:
      get_tree().get_root().get_node("Graveyard_Level").get_node("Old_Man").old_man_lv1 = false
      queue_text("OLD MAN: Greetings HERO! I have been watching your actions since you got here. These evil spirits needed to be stopped. ")
      queue_text("OLD MAN: I can tell, you are doing this because of your sense of duty and respect to let the departed rest in peace.")
      queue_text("OLD MAN: I can tell a LOT about a person at a glance.")
      queue_text("OLD MAN: Your heart and mind tell me you are of good character. There is a lot you will achieve. Take this as a parting gift. We will surely meet again.")
  if get_parent().get_child(0).name == "Castle_Level":
    if get_tree().get_root().get_node("Castle_Level").get_node("Old_Man").old_man_lv2 == true: 
      get_tree().get_root().get_node("Castle_Level").get_node("Old_Man").old_man_lv2 = false
      queue_text("OLD MAN: Looks like I missed the good part. Just kidding! You have yet again saved the day. Kudos. As a personal token of appreciation from me, here.")
      queue_text("OLD MAN:I am sure those ladies are very greatful and releived. Maybe, one might even give you a token of appreciation like me!")
  

func _process(delta):
  match current_state:
    State.READY:
      if !text_queue.empty():
        display_text()
    State.READING:
      if Input.is_action_just_pressed("ui_accept"):
        label.percent_visible = 1.0
        $Tween.remove_all()
        end_symbol.text = "v"
        change_state(State.FINISHED)
    State.FINISHED:
      if Input.is_action_just_pressed("ui_accept"):
        change_state(State.READY)
        hide_textbox()

func queue_text(next_text):
  text_queue.push_back(next_text)

func hide_textbox():
  start_symbol.text = ""
  end_symbol.text = ""
  label.text = ""
  textbox_container.hide()

func show_textbox():
  start_symbol.text = "*"
  textbox_container.show()

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
      print("")
    State.READING:
      print("")
    State.FINISHED:
      print("")

func _on_Tween_tween_completed(object, key):
  end_symbol.text = "v"
  change_state(State.FINISHED)
