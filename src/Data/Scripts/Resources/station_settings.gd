class_name StationSettings
extends RailLogicSettings

@export var assigned_signal_name := ""
@export var enable_person_system := true
@export var overwrite := false


func duplicate(deep: bool = true):
	var copy = get_script().new()

	copy.assigned_signal_name = assigned_signal_name
	copy.enable_person_system = enable_person_system
	copy.overwrite = overwrite

	return copy
