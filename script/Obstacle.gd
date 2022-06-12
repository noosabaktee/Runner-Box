extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	translation.z -= 0.2
	if translation.z <= -35:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_obstacle_body_entered(body):
	body._on_die()
	get_parent().get_parent().save()
