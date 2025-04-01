extends Area3D

func _on_body_entered(body):
	print("body entered coin")
	if body.has_method("collect_coin"):
		print("body has collect_coin")
		body.collect_coin()
		queue_free()