extends CharacterBody3D

const SPEED = 3.0

@export var player_path : NodePath
@onready var player = null

enum States { IDLE, RUNNING, ATTACKING }

var state: States = States.IDLE
var state_functions = {}

@onready var nav_agent = $NavigationAgent3D

@onready var model : Node3D = $Skeleton_Minion
@onready var animation = $Skeleton_Minion/AnimationPlayer


func _ready():
  player = get_node(player_path)

func _process(_delta):
  velocity = Vector3.ZERO

  nav_agent.set_target_position(player.global_transform.origin)
  var next_nav_point = nav_agent.get_next_path_position()
  velocity = (next_nav_point - global_transform.origin).normalized() * SPEED

  look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

  move_and_slide()
  animation.play("Running_A", 0.1)

func receive_attack():
  queue_free()
func _on_attack_area_body_entered(body:Node3D):
  if body.has_method("take_damage"):
    body.take_damage()