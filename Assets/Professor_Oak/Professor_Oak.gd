extends KinematicBody2D

var can_interact:bool = false
const DIALOG = preload("res://Assets/DialogBox/DialogBox.tscn")


func _physics_process(delta):
	$AnimationPlayer.play("IDLE")
	
	
func _ready():
	pass
	

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Label.visible = true
		can_interact = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$Label.visible = false
		can_interact = false


func _input(event):
	if Input.is_key_pressed(KEY_Z) and can_interact == true:
		$Label.visible = false
		var dialog = DIALOG.instance()
		get_parent().add_child(dialog)
		
