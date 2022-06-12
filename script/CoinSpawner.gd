extends Timer

var coin = preload("res://assets/Coin.tscn") 
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
	var nodeInstance = coin.instance()
	if random_value == 0:
		nodeInstance.translate(Vector3(0,0,0))
	elif random_value == 1:
		nodeInstance.translate(Vector3(3,0,0))
	else:
		nodeInstance.translate(Vector3(-3,0,0))
	get_parent().add_child(nodeInstance)

