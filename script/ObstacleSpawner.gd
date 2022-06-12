extends Timer

var left = preload("res://assets/obstacle_left.tscn") 
var right = preload("res://assets/obstacle_right.tscn") 
var center = preload("res://assets/obstacle_center.tscn") 
var down = preload("res://assets/obstacle_down.tscn") 
var obstacle_list = [left, right, center, down]
var _timer = null

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	randomize()
	var random_value = round(rand_range(0,3))
	var nodeInstance = obstacle_list[random_value].instance()
	nodeInstance.translate(Vector3(0,0,0))
	get_parent().add_child(nodeInstance)

