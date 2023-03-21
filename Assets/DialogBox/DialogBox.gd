extends Control

var dialog = [
	"Olá Ash, seja bem-vindo ao laboratório Pokémon.",
	"Hoje você escolherá seu primeiro Pokémon para iniciar sua jornada",
	"Vá até a mesa a minha esquerda e escolha uma entre essas 3 pokebolas",
]

var dialog_index = 0
var finished:bool = false

func _ready():
	load_dialog()
	
func _physics_process(delta):
	var _delta = delta
	$DialogBox/Sprite.visible = finished
	if Input.is_action_just_pressed("z"):
		load_dialog()
	
func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$DialogBox/RichTextLabel.bbcode_text = dialog[dialog_index]
		$DialogBox/RichTextLabel.percent_visible = 0
		$DialogBox/Tween.interpolate_property($DialogBox/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$DialogBox/Tween.start()
	else:
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
