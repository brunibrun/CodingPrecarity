extends Control

class_name ShapeData

# warning-ignore:unused_class_variable
var color: Color
var grid: Array
var coors: Array
var cells: GridContainer

func rotate_left():
	for cell in cells.get_children():
		var rotated_cell = cell.duplicate(true)
		rotated_cell.rect_rotation = 90
		cell = rotated_cell
	_rotate_grid(-1, 1)


func rotate_right():
	for cell in cells.get_children():
		var rotated_cell = cell.duplicate(true)
		rotated_cell.rect_rotation = 90
		cell = rotated_cell
	_rotate_grid(1, -1)


func _rotate_grid(sign_of_x, sign_of_y):
	var rotated_grid = grid.duplicate(true)
	for x in coors:
		for y in coors:
			# Map x and y to array indices
			var x1 = coors.find(x)
			var y1 = coors.find(y)
			var x2 = coors.find(sign_of_y * y)
			var y2 = coors.find(sign_of_x * x)
			rotated_grid[y1][x1] = grid[y2][x2]
	grid = rotated_grid