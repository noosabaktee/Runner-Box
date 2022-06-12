extends Spatial


var skinSelect = 0
var priceList = [0,1000,5000,10000,20000,50000]
var buy = [0]
var fileName = "user://save_game.dat"


# Called when the node enters the scene tree for the first time.
func _ready():
	buy = loadData("buy")
	for x in range(0, $Cube/CollisionShape.get_child_count()):
		get_node("Cube/CollisionShape/" + str(x)).visible = false
	get_node("Cube/CollisionShape/" + str(skinSelect)).visible = true

func _physics_process(delta):
	if(skinSelect == 0):
		$CanvasLayer/Kiri/Button.visible = false
	else:
		$CanvasLayer/Kiri/Button.visible = true
			
	if(skinSelect == 5):
		$CanvasLayer/Kanan/Button.visible = false
	else:
		$CanvasLayer/Kanan/Button.visible = true
		
	var coin = loadData("coin")
	$CanvasLayer/Control/CoinPanel/CoinText.text = "Coin: " + str(coin)
	$CanvasLayer/Price/Label.text = str(priceList[skinSelect])
	$Cube.rotate_y(0.011)
	set_buy_text()
	print(loadData("skin"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_pressed():
	$Click.play()
	for x in range(0, $Cube/CollisionShape.get_child_count()):
		get_node("Cube/CollisionShape/" + str(x)).visible = false
	skinSelect += 1
	get_node("Cube/CollisionShape/" + str(skinSelect)).visible = true


func _on_Prev_pressed():
	$Click.play()
	for x in range(0, $Cube/CollisionShape.get_child_count()):
		get_node("Cube/CollisionShape/" + str(x)).visible = false
	skinSelect -= 1
	get_node("Cube/CollisionShape/" + str(skinSelect)).visible = true


func _on_Back_pressed():
	$Click.play()
	get_tree().change_scene("res://Menu.tscn")


func _on_Buy_pressed():
	$Click.play()
	var coin = loadData("coin")
	if $CanvasLayer/Buy.text == "Buy":
		# BUY
		if coin >= priceList[skinSelect]:
			buy.append(skinSelect)
			save("buy")
	else:
		save("select")
		
	
func loadData(param):
	var get = File.new()
	get.open(fileName, File.READ)
	var result = get.get_var()
	get.close()
	return result[param]
	
func save(info):
	# PARAMS FILL BY "BUY" OR "SELECT"
	var skin = loadData("skin")
	var newCoin = loadData("coin") - priceList[skinSelect]
	if info == "select":
		skin = skinSelect
		newCoin = loadData("coin")

	var file = File.new()
	file.open(fileName, File.WRITE)
	var content = {
		"coin": newCoin,
		"skin": skin,
		"buy": buy
	}
	file.store_var(content)
	file.close()
	
func set_buy_text():
	# CHANGE BUY TEXT TO SELECT/SELECTED IF OBJECT HAS BOUGHT
	var myRealSkin = loadData("skin")
	if myRealSkin == skinSelect:
		$CanvasLayer/Buy.text = "Selected"
	elif skinSelect in buy:
		$CanvasLayer/Buy.text = "Select"
	else:
		$CanvasLayer/Buy.text = "Buy"
		
