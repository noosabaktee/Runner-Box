extends KinematicBody

var swipe_start = null
var swipe_end = null
var swipe_start_y = null
var swipe_end_y = null
var gravity = 9.8
var jump = 5
var capncrunch = Vector3()
var effect = preload("res://assets/Effect.tscn") 
var die = false
var minimum_drag = 100

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
		  swipe_start = event.get_position()
		else:
		  _calculate_swipe(event.get_position())


func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			move_left_right("right")
		else:
			move_left_right("left")
			
	if abs(swipe.y) > minimum_drag:
		if swipe.y < 0:
			capncrunch.y = jump
			move_and_slide(capncrunch, Vector3.UP)
		else:
			capncrunch.y -= 7
			move_and_slide(capncrunch, Vector3.UP)

	
func _physics_process(delta):
#	Spawn Effect
	var nodeInstance = effect.instance()
	nodeInstance.translation.z = translation.z
	nodeInstance.translation.x = translation.x
	if is_on_floor():
		get_parent().add_child(nodeInstance)
	
#	Jump
	if not is_on_floor():
		capncrunch.y -= gravity * delta
		
	move_and_slide(capncrunch, Vector3.UP)



func _input(event):
#	Click Input
	if Input.is_action_just_pressed("ui_right"):
		move_left_right("right")
	if Input.is_action_just_pressed("ui_left"):
		move_left_right("left")
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		capncrunch.y = jump
		move_and_slide(capncrunch, Vector3.UP)
	if Input.is_action_just_pressed("ui_down") && not is_on_floor():
		capncrunch.y -= 7
		move_and_slide(capncrunch, Vector3.UP)
	
#	Swipe Input
#	if Input.is_action_just_pressed("click"):
#		swipe_start = get_viewport().get_mouse_position().x
#		swipe_start_y = get_viewport().get_mouse_position().y
#	if Input.is_action_just_released("click"):
#		swipe_end = get_viewport().get_mouse_position().x
#		swipe_end_y = get_viewport().get_mouse_position().y
#		if (swipe_start+50) < swipe_end:
#			move_left_right("right")
#		elif (swipe_start-50) > swipe_end:
#			move_left_right("left")
#		elif(swipe_start_y-50) > swipe_end_y && is_on_floor():
#			capncrunch.y = jump
#			move_and_slide(capncrunch, Vector3.UP)
#		elif(swipe_start_y+50) < swipe_end_y && not is_on_floor():
#			capncrunch.y -= 7
#			move_and_slide(capncrunch, Vector3.UP)


	
	
func move_left_right(move):
	if(move == "right" && round(transform.origin.x) == 2):
		transform.origin.x = 0
	elif(move == "right" && round(transform.origin.x) == 0):
		transform.origin.x = -2
	elif(move == "left" && round(transform.origin.x) == 0):
		transform.origin.x = 2
	elif(move == "left" && round(transform.origin.x) == -2):
		transform.origin.x = 0
	get_parent().get_node("Swipe").play()
		
func _on_die():
	get_parent().get_node("Crash").play()
	die = true
	get_parent().get_node("CanvasLayer/Restart/BtnRestart").show()
	get_tree().paused = true

