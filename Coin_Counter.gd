extends Node

var coin_count = 0

func increase_coin_count():
	coin_count += 1;
	get_node("../Camera2D/Coin_Counter_Label").text = str(coin_count)
