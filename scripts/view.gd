extends Node3D

@export_group("Properties")
@export var target: Node

@export_group("Rotation")
@export var rotation_speed : int = 120

var camera_rotation : Vector3
var zoom = 10

@onready var camera : Camera3D = $Camera

func _ready():
	
	camera_rotation = rotation_degrees # Initial rotation
	
	pass

func _physics_process(delta):
	
	# Set position and rotation to targets
	
	self.position = self.position.lerp(target.position, delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	
	# camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
