extends CenterContainer

var grid
var next

var music = 0
var sound = 0
var min_vol

var level = 1 setget set_level
var score = 0 setget set_score
#var high_score = 0 setget set_high_score
var lines = 0 setget set_lines
var timer = 120 setget set_timer
var goal = 15 setget set_goal

signal button_pressed(button_name)

func set_level(value):
	find_node("Level").text = str(value)
	level = value


func set_score(value):
	find_node("Score").text = str(value)
	score = value


func set_timer(value):
	find_node("Cuntdown").text = str(value)
	timer = value


#func set_high_score(value):
#	find_node("HighScore").text = "%08d" % value
#	high_score = value


func set_lines(value):
	find_node("Lines").text = str(value)
	lines = value


func set_goal(value):
	find_node("Goal").text = str(value)
	goal = value

func reset_stats( _score = 0, _lines = 0, _level = 1, _timer = 120, _goal = 20):
	#self.high_score = _high_score
	self.score = _score
	self.lines = _lines
	self.level = _level
	self.timer = _timer
	self.goal  = _goal


func settings(data):
	#self.high_score = data.high_score
	find_node("Music").value = data.music
	find_node("Sound").value = data.sound


func _ready():
	grid = find_node("Grid")
	next = find_node("Next")
	min_vol = find_node("Music").get_min()
	find_node("Sound").set_min(min_vol)
	add_cells(grid, 200)
	clear_all_cells()


func set_next_shape(shape: ShapeData):
	clear_cells(next)
	var i = 0
	for col in shape.coors.size():
		for row in [0, 1]:
			if shape.grid[row][col]:
				next.get_child(i).modulate = shape.color
				next.get_child(i).texture = shape.cells.get_child(i).texture
			i += 1


func add_cells(node, n):
	var num_cells = node.get_child_count()
	while num_cells < n:
		node.add_child(node.get_child(0).duplicate())
		num_cells += 1


func clear_all_cells():
	clear_cells(grid)
	clear_cells(next)


func clear_cells(node):
	for cell in node.get_children():
		cell.modulate = Color(1)


func _on_About_button_down():
	$AboutBox.popup_centered()
	emit_signal("button_pressed", "About")


func _on_NewGame_button_down():
	emit_signal("button_pressed", "NewGame")


func _on_Pause_button_down():
	emit_signal("button_pressed", "Pause")


func set_button_state(button, state):
	find_node(button).set_disabled(state)


func set_button_text(button, text):
	find_node(button).set_text(text)


func _on_AboutBox_popup_hide():
	set_button_state("About", false)


func set_button_states(playing):
	set_button_state("NewGame", playing)
	set_button_state("About", playing)
	set_button_state("Pause", !playing)


func _on_Music_value_changed(value):
	music = value
	emit_signal("button_pressed", "Music")


func _on_Sound_value_changed(value):
	sound = value
	emit_signal("button_pressed", "Sound")
