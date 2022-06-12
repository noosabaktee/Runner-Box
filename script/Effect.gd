extends MeshInstance

var fileName = "user://save_game.dat"

# Called when the node enters the scene tree for the first time.
func _ready():
	var skinSelect = loadData("skin")
#	Get albedo color from player
	var material = get_parent().get_node("Player/CollisionShape/"+str(skinSelect)).get_surface_material(0) 
	var skinColor = material.albedo_color
	self.get_surface_material(0).albedo_color = skinColor


func _physics_process(delta):
	translation.z -= 0.2
	if translation.z <= -20:
		queue_free()

func loadData(param):
	var get = File.new()
	get.open(fileName, File.READ)
	var result = get.get_var()
	get.close()
	return result[param]
