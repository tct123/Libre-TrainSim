class_name ModContentDefinition
extends Resource


@export var unique_name: String = ""
@export var display_name: String = ""

@export var version_major: int = 1
@export var version_minor: int = 0
@export var version_patch: int = 0

# example: { "unique_name": "example_mod", "version": ">=1.0.0" }
@export var depends_on: Array = [] # (Array, Dictionary)

@export var environment_folders: Array = [] # (Array, String, DIR)
@export var material_folders: Array = [] # (Array, String, DIR)
@export var music_folders: Array = [] # (Array, String, DIR)
@export var object_folders: Array = [] # (Array, String, DIR)
@export var persons_folders: Array = [] # (Array, String, DIR)
@export var rail_type_folders: Array = [] # (Array, String, DIR)
@export var signal_type_folders: Array = [] # (Array, String, DIR)
@export var sound_folders: Array = [] # (Array, String, DIR)
@export var texture_folders: Array = [] # (Array, String, DIR)

@export var trains: Array = [] # (Array, String, FILE, "*.tscn,*.scn")
@export var worlds: Array = [] # (Array, String, FILE, "*.tscn,*.scn")


func _init() -> void:
	depends_on = []
	environment_folders = []
	material_folders = []
	music_folders = []
	object_folders = []
	persons_folders = []
	rail_type_folders = []
	signal_type_folders = []
	sound_folders = []
	texture_folders = []
	trains = []
	worlds = []


# get version as array
func _semver() -> Array:
	return [version_major, version_minor, version_patch]


# get version as string
func _semver_to_string() -> String:
	return "%s.%s.%s" % _semver()


# make semver from a string
func _semver_from_string(version: String) -> Array:
	var numbers = version.split(".", false)
	if len(numbers) != 3:
		Logger.error("Invalid String used for Semver: %s" % version, self)
		return [float("NaN"), float("NaN"), float("NaN")]
	return [int(numbers[0]), int(numbers[1]), int(numbers[2])]


# check version against version definition (String) like ">=1.0.0"
func _check_semver(version: String) -> bool:
	var version_to_check := []
	var is_valid := false

	if version.begins_with(">="):
		version_to_check = _semver_from_string(version.substr(2))
		is_valid = (version_major >= version_to_check[0]) \
				or (version_minor >= version_to_check[1]) \
				or (version_patch >= version_to_check[2])
	elif version.begins_with("<="):
		version_to_check = _semver_from_string(version.substr(2))
		is_valid = (version_major <= version_to_check[0]) \
				or (version_minor <= version_to_check[1]) \
				or (version_patch <= version_to_check[2])
	elif version.begins_with(">"):
		version_to_check = _semver_from_string(version.substr(1))
		is_valid = (version_major > version_to_check[0]) \
				or (version_minor > version_to_check[1]) \
				or (version_patch > version_to_check[2])
	elif version.begins_with("<"):
		version_to_check = _semver_from_string(version.substr(1))
		is_valid = (version_major < version_to_check[0]) \
				or (version_minor < version_to_check[1]) \
				or (version_patch < version_to_check[2])
	elif version.begins_with("="):
		version_to_check = _semver_from_string(version.substr(1))
		is_valid = (version_major == version_to_check[0]) \
				and (version_minor == version_to_check[1]) \
				and (version_patch == version_to_check[2])
	else:
		version_to_check = _semver_from_string(version)
		is_valid = (version_major >= version_to_check[0]) \
				or (version_minor >= version_to_check[1]) \
				or (version_patch >= version_to_check[2])

	return is_valid
