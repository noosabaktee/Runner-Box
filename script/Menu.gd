extends Node2D

var fileName = "user://save_game.dat"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	var file = File.new()
	if !file.file_exists(fileName):
		file.open(fileName, File.WRITE)
		var content = {
			"coin": 0,
			"skin": 0,
			"buy": [0]
		}
		file.store_var(content)
	file.close()
	var coin = loadData("coin")
	$CanvasLayer/CoinPanel/CoinText.text = "Coin: " + str(coin)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func loadData(param):
	var get = File.new()
	get.open(fileName, File.READ)
	var result = get.get_var()
	get.close()
	return result[param]


func _on_Exit_pressed():
	$Click.play()
	get_tree().quit()



func _on_Start_pressed():
	$Click.play()
	get_tree().change_scene("res://Scene.tscn")



func _on_Buy_pressed():
	$Click.play()
	get_tree().change_scene("res://Buy.tscn")
