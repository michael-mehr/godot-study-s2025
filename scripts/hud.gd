extends Control

func _on_coin_collected(coins):
	$CoinCounter/Coins.text = str(coins)
