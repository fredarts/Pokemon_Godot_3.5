extends Node2D

enum Options {FIRST_SLOT, SECOND_SLOT, THIRD_SLOT, FOURTH_SLOT, FIFTH_SLOT, SIXTH_SLOT, CANCEL}
var selected_options: int = Options.FIRST_SLOT

onready var options: Dictionary = {
	Options.FIRST_SLOT: $FirstPokemonSlot/Background,
	Options.SECOND_SLOT: $SecondPokemonSlot/Background,
	Options.THIRD_SLOT: $ThirdPokemonSlot/Background,
	Options.FOURTH_SLOT: $FourthPokemonSlot/Background,
	Options.FIFTH_SLOT: $FifthPokemonSlot/Background,
	Options.SIXTH_SLOT: $SixthPokemonSlot/Background,
	Options.CANCEL: $CancelSprite,
	
}

func unset_active_option():
	options[selected_options].frame = 0
	
func set_active_option():
	options[selected_options].frame = 1

func _ready():
	set_active_option()
	
func _input(event):
	if event.is_action_pressed("ui_down"):
		unset_active_option()
		selected_options = (selected_options + 1) % 7
		set_active_option()
	elif event.is_action_pressed("ui_up"):
		unset_active_option()
		if selected_options == 0:
			selected_options = Options.CANCEL
		else:
			selected_options -= 1
		set_active_option() 
	elif event.is_action_pressed("ui_left"):
		unset_active_option()
		selected_options = 0
		set_active_option()
	elif event.is_action_pressed("ui_right") and selected_options == Options.FIRST_SLOT:
		unset_active_option()
		selected_options = 1
		set_active_option()
	elif event.is_action_pressed("z") and selected_options == Options.CANCEL:
		Utils.get_scene_manager().transition_exit_party_screen()
		

