class_name Pause
extends Control

signal paused
signal unpaused


var _saved_ingame_pause: bool = false
var _saved_mouse_mode: int = 0
var player: LTSPlayer


func _ready() -> void:
	$StationJumper.connect("hide", $CenterContainer/HBox/JumpToStation, "grab_focus")
	jSettings.get_node("JSettings").connect("hide", $CenterContainer/HBox/Settings, "grab_focus")


func show() -> void:
	$CenterContainer/HBox/Back.grab_focus()
	.show()


func _unhandled_input(_event) -> void:
	if not jSettings.get_node("JSettings").visible and Input.is_action_just_pressed("pause"):
		if visible:
			unpause()
		else:
			pause()
	if Input.is_action_just_pressed("ingame_pause"):
		if Root.game_pause["ingame_pause"] and Root.game_pause.values().count(true) == 1:
			Root.set_game_pause("ingame_pause", false)
		elif not get_tree().paused:
			Root.set_game_pause("ingame_pause", true)
			jEssentials.show_message(tr("PAUSE_MODE_ENABLED"))
	if visible and Input.is_action_just_released("ui_accept"):
		# Prevent "ui_accept" event from closing a potential message behind the menu
		accept_event()


func pause():
	Root.set_game_pause("pause_menu", true)
	show()
	_saved_mouse_mode = Input.get_mouse_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("paused")

func unpause():
	Root.set_game_pause("pause_menu", false)
	hide()
	Input.set_mouse_mode(_saved_mouse_mode)
	emit_signal("unpaused")


func _on_Back_pressed() -> void:
	unpause()
	# The pause menu is already closed, so the "ui_accept" event would not be caught when it reaches _unhandled_input
	accept_event()


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_QuitMenu_pressed() -> void:
	jAudioManager.clear_all_sounds()
	jEssentials.remove_all_pending_delayed_calls()
	LoadingScreen.load_main_menu()


func _on_JumpToStation_pressed() -> void:
	$StationJumper.update_list(player)
	$StationJumper.show()


func _on_StationJumper_station_index_selected(station_index: int) -> void:
	_on_Back_pressed()
	find_parent("World").jump_player_to_station(station_index)


func _on_RestartScenario_pressed() -> void:
	Root.reset_game_pause()
	jEssentials.remove_all_pending_delayed_calls()
	jAudioManager.clear_all_sounds()
	var _unused = get_tree().reload_current_scene()


func _on_Settings_pressed() -> void:
	jSettings.popup()
