class_name WorldConfig
extends Resource


# I don't like it, but this is what OS.get_date() would return
# so let's stick to Godots chosen way of doing it.
@export var release_date := {
	"year": 1989,
	"month": 11,
	"day": 9
}
@export var title := "Untitled"  # right now, the filename is used I think
@export var author := "Unknown"
@export var track_description := "n/a"

# set this to false if you want to make underground maps, for example
@export var generate_grass := true

# AFAIK this is a hardcoded path anyways
#export(String, FILE, "*.png,*.jpeg,*.jpg,*.bmp,*.gif") var thumbnail_path := ""

# shown in the editor
@export var editor_notes := ""


func get_release_date_string() -> String:
	return "%d.%d.%d" % [release_date.day, release_date.month, release_date.year]
