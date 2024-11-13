extends Node
# Loads, updates and save user config settings

var user_path : String = OS.get_user_data_dir()
var settings_file_path : String = user_path + "/settings.ini"
var current_settings : Dictionary
var default_settings : Dictionary = {
	"display" : {
		"window_size" : 2,
		"fullscreen" : true,
	},
	"control" : {}
}

func _ready():
	EventBus.window_size_changed.connect(_change_window_size)
	EventBus.window_mode_toggled.connect(_toggle_fullscreen)
	if not _does_settings_file_exist():
		_create_default_settings_file()
	_load_settings() # reads data from file and writes it into a temp dict
	_init_settings()
	pass

func _does_settings_file_exist() -> bool:
	if FileAccess.file_exists(settings_file_path):
		return true
	return false

func _create_default_settings_file() -> void:
	var new_config = ConfigFile.new()
	new_config.set_value("Settings", "display", default_settings.display)
	new_config.set_value("Settings", "controls",default_settings.control )
	new_config.save(settings_file_path)
	pass

# Reads the settings file and writes the data to current_settings : dict
func _load_settings() -> void:
	if FileAccess.file_exists(settings_file_path):
		var new_config = ConfigFile.new()
		var err = new_config.load(settings_file_path)
		if err != OK:
			return 
		var sections = new_config.get_sections()
		for section in sections:
			var keys = new_config.get_section_keys(section)
			for key in keys:
				# Keys even in different sections cannot have the same name
				current_settings[key] = new_config.get_value(section, key)


func _init_settings() -> void:
	_change_window_size(current_settings["display"].window_size)
	_toggle_fullscreen(current_settings["display"].fullscreen)

# Can also be accessed by options_menu.gd, thus the first 2 lines
func _change_window_size(index):
	current_settings["display"].window_size = index
	_save_user_config()
	match index:
		0:  # 640×360 (16:9)
			DisplayServer.window_set_size(Vector2i(640, 360))
		1:  # 640×480 (4:3)
			DisplayServer.window_set_size(Vector2i(640, 480))
		2:  # 1280×720 (16:9)
			DisplayServer.window_set_size(Vector2i(1280, 720))
		3:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
	DisplayServer.window_set_position(Vector2(DisplayServer.screen_get_position()) + DisplayServer.screen_get_size()*0.5 - DisplayServer.window_get_size()*0.5)

func _toggle_fullscreen(button_pressed):
	UserConfig.current_settings["display"].fullscreen = button_pressed
	if button_pressed == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	_save_user_config()

func _save_user_config():
	if FileAccess.file_exists(settings_file_path):
		var new_config = ConfigFile.new()
		var err = new_config.load(settings_file_path)
		if err != OK:
			return
		new_config.set_value("Settings", "display", current_settings["display"])
		new_config.set_value("Settings", "controls",current_settings["controls"])
		new_config.save(settings_file_path)
