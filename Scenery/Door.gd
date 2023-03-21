extends Area2D


export(bool) var is_invisible = false
export(String, FILE) var next_scene_path = ""
export(Vector2) var spawn_location = Vector2(0,0)
export(Vector2) var spawn_direction = Vector2(0,0)
onready var sprite: Sprite = $Sprite
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var door_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player_entered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_invisible:
		$Sprite.texture = null
	sprite.visible = false
	var player = Utils.get_player()
	player.connect("player_entering_door_signal", self, "entered_door")
	player.connect("player_entered_door_signal", self, "close_door")
	
func entered_door():
	if player_entered:
		anim_player.play("OpenDoor")
		door_sfx.play()
	
func close_door():
	if player_entered:
		anim_player.play("CloseDoor")

func door_closed():
	if player_entered:
		Utils.get_scene_manager().transition_to_scene(next_scene_path, spawn_location, spawn_direction) 
	


func _on_Door_body_entered(body):
	var _body = body
	player_entered = true


func _on_Door_body_exited(body):
	var _body = body
	player_entered = false
