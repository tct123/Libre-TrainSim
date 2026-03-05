extends PassengerPathNode

@export var side := DoorSide.UNASSIGNED # (DoorSide.TypeHint)

func _init() -> void:
	type = Type.DOOR
