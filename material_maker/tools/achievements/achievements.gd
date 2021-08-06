extends Node

var unlocked : Array = []

const ACHIEVEMENTS : Array = [
	{
		name = "User Interface",
		achievements = [
			{
				id = "ui_start",
				name = "First step",
				hint = "Start Material Maker for the first time",
				description = "Welcome!"
			},
			{
				id = "ui_dropnode",
				name = "Add your first node",
				hint = "Drop a node from the Library to a graph",
				description = "You did it!"
			},
			{
				id = "ui_createnode",
				name = "Add your second node",
				hint = "Create a node using the add node menu",
				description = "You did it again!"
			}
		]
	}
]

var config = null

func set_config(config_cache):
	config = config_cache
	if config.has_section_key("achievements", "unlocked"):
		unlocked = config.get_value("achievements", "unlocked").split(",")
	unlock("ui_start")

func unlock(achievement : String):
	if unlocked.find(achievement) != -1:
		return
	unlocked.push_back(achievement)
	config.set_value("achievements", "unlocked", PoolStringArray(unlocked).join(","))
	for s in ACHIEVEMENTS:
		for a in s.achievements:
			if achievement == a.id:
				var achievement_widget = load("res://material_maker/tools/achievements/new_achievement.tscn").instance()
				achievement_widget.set_texts(a.name, a.description)
				add_child(achievement_widget)
				return
