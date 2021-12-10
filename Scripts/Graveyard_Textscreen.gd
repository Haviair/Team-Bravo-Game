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
  queue_text("Welcome to the kingdom of Writtenburg. It is a land of many wonders and even more mysteries. It hasn't quite caught up to the modern world yet. ")
  queue_text("This kingdom is inhabited by all sorts of creatures and various races like elf, beastman, and humans to name some.")
  queue_text("There are many things one can do to earn ones bread. One of the most profound professions is that of the warrior. There are several types of warriors: swordsman, brute, mage, healer, and even archer, just to name some.")
  queue_text("Some join guilds, some work for the kingdom fulltime, and some take missions on commission.")
  queue_text("There is a hierarchy  among the warrior classes that ranks one to be 'above' or 'better' than the other. The archer class is among the lowest and considered the weakest and looked down upon by every other.")
  queue_text("Enter our HERO, a human warrior, an archer to be specific, who sets out to prove that the archer class is strong and reliable too and has its own merits and wants those around him to stop looking down on the class and remove their prejudice.")
  queue_text("He sets out to do this by completing demanding missions fruitfully and gaining the favor of the kingdom.")
  queue_text("He looks up the missions posted. He finds one stating that the local graveyard has been infested with evil sprits and that someone is to investigate the matter. Deciding he must start somewhere, he embarks on this mission.")
  queue_text("The Hero goes to the graveyard and waits, hidden from sight. He sees bandits arriving. ")
  queue_text("Bandit 1: ' hatching an idea to make a quick buck selling valuables buried with the dead was a good one '. Bandit 2: ' These people are all DEAD, they wont be needing these anymore anyway. ' The hero makes his presence known. Hero: ' STOP! let the departed rest in peace. you will all have to pay for your crimes '. ")
  queue_text("The bandits attack our Hero. The spirits of the departed, whose eternal rest was disturbed, have come, in the corporeal form of ghosts, to exact vengeance on their wrongdoers. The bandits take this as a sign to retreat with their tails tucked behind their legs. The hero however, must defeat them and let them go back to their eternal slumber.")
  
  
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
