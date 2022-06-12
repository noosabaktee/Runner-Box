extends Spatial

var coin = 0
var fileName = "user://save_game.dat"
var skinSelect = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	skinSelect = loadData("skin")
	for x in range(0, $Player/CollisionShape.get_child_count()):
		get_node("Player/CollisionShape/" + str(x)).visible = false
	get_node("Player/CollisionShape/" + str(skinSelect)).visible = true
	$CanvasLayer/Restart/BtnRestart.hide()
	$CanvasLayer/PauseMenu.hide()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		get_tree().paused = true
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = false


func _on_Button_pressed():
	$Click.play()
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_BtnPause_pressed():
	$Click.play()
	if $Player.die == true:
		$CanvasLayer/Restart.hide()
	
	$CanvasLayer/PauseMenu.show()
	get_tree().paused = true

func _on_Resume_pressed():
	$Click.play()
	if $Player.die == true:
		get_tree().reload_current_scene()
		
	get_tree().paused = false
	$CanvasLayer/PauseMenu.hide()


func _on_MainMenu_pressed():
	$Click.play()
	get_tree().change_scene("res://Menu.tscn")
	
func save():
	var newCoin = loadData("coin") + coin
	var skin = loadData("skin")
	var buy = loadData("buy")
	var file = File.new()
	file.open(fileName, File.WRITE)
	var content = {
		"coin": newCoin,
		"skin": skin,
		"buy": buy
	}
	file.store_var(content)
	file.close()


func loadData(param):
	var get = File.new()
	get.open(fileName, File.READ)
	var result = get.get_var()
	get.close()
	return result[param]



