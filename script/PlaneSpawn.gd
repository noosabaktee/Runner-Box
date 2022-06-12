extends CollisionShape

var plane = preload("res://assets/PlaneMesh.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_child(get_child_count()-1).get_translation())
	var nodeInstance = plane.instance()
	nodeInstance.translate(Vector3(0,0,2))
	add_child(nodeInstance)
	var nodeInstance2 = plane.instance()
	nodeInstance2.translate(Vector3(0,0,4))
	add_child(nodeInstance2)
	print(get_child(get_child_count()-1).get_translation())
	print(get_children()[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


