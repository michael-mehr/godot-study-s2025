extends Area3D

func _on_body_entered(body):
	if body.has_method("collect_coin"):
		
		body.collect_coin()
		
		queue_free()