extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var coinText = null


# Called when the node enters the scene tree for the first time.
func _ready():
	coinText = get_parent().get_parent().get_node("CanvasLayer/CoinPanel/CoinText")

func _physics_process(delta):
	rotate_y(0.09)
	translation.z -= 0.2
	if translation.z <= -40:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_body_entered(body):
	get_parent().get_parent().get_node("Coin").play()
	get_parent().get_parent().coin += 10
	coinText.text = "Coin: +" + str(get_parent().get_parent().coin)
	queue_free()
