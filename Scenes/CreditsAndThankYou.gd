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
  queue_text("Thank You for Playing!")
  queue_text("Credits")
  queue_text("Javier Gonzalez \t---\t Main Programmer \n Nihal Kumarswamy --- Enemy & Boss Creator/ Github Manager \n Sai Venkata Bhanu Shasank Bonthala --- Level Designer \n Ojus Mamatha Srikanth --- Screen Writer")
  queue_text("Art\n 9E0 \t---\t Witches Pack \n LuizMelo \t---\t Monsters Creatures Fantasy Pack\n GameSupplyGuy \t---\t Special Material Orbs\n Maytch \t---\t 16x16 Pixel Art 8-Directional Characters\n")
  queue_text("Sounds\n szegvari \t---\t Dark Castle Atmosphere \n Vital_Sounds \t---\t Open Field September\n")
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
    get_tree().quit()

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
