extends Control

var main_scene = preload("res://scenes/main.tscn")

func _on_start_button_pressed():
  get_tree().change_scene_to_packed(main_scene)
  pass

func _on_quit_button_pressed():
  get_tree().quit()
  pass # Replace with function body.
