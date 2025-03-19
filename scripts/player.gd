extends CharacterBody3D

@export_subgroup("Components")
@export var view : Node3D

@export_subgroup("Properties")
@export var movement_speed = 500
@export var jump_strength = 15

var movement_velocity : Vector3
var rotation_direction : float
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true

var coins : int = 0

@onready var model : Node3D = $Knight
@onready var animation = $Knight/AnimationPlayer

func _physics_process(delta):
  handle_controls(delta)
  handle_gravity(delta)
  handle_effects(delta)

  var applied_velocity : Vector3

  applied_velocity = velocity.lerp(movement_velocity, delta * 10)
  applied_velocity.y = -gravity

  velocity = applied_velocity
  move_and_slide()

  if Vector2(velocity.z, velocity.x).length() > 0:
    rotation_direction = Vector2(velocity.z, velocity.x).angle()

  rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)

  # Falling/respawning

  if position.y < -10:
    get_tree().reload_current_scene()

  # Animation for scale (jumping and landing)

  model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)

  # Animation when landing

  if is_on_floor() and gravity > 2 and !previously_floored:
    model.scale = Vector3(1.25, 0.75, 1.25)

  previously_floored = is_on_floor()

func handle_effects(delta):
  if is_on_floor():
    var horizontal_velocity : Vector2 = Vector2(velocity.x, velocity.z)
    var speed_factor : float = horizontal_velocity.length() / movement_speed / delta
    if speed_factor > 0.05:
      if animation.current_animation != "Running_A":
        animation.play("Running_A", 0.1)
    elif animation.current_animation != "Idle":
      animation.play("Idle", 0.1)
  # elif animation.current_animation != "jump":
  #   animation.play("jump", 0.1)


func handle_controls(delta):
  var input := Vector3.ZERO

  input.x = Input.get_axis("move_left", "move_right")
  input.z = Input.get_axis("move_forward", "move_back")

  # input = input.rotated(Vector3.UP, view.rotation.y)

  if input.length() > 1:
    input = input.normalized()

  movement_velocity = input * movement_speed * delta

  if Input.is_action_just_pressed("jump"):
    if jump_single or jump_double:
      jump()

func handle_gravity(delta):
  gravity += 25 * delta
  if gravity > 0 and is_on_floor():
    jump_single = true
    gravity = 0

func jump():
  gravity = -jump_strength
  model.scale = Vector3(0.5, 1.5, 0.5)
  if jump_single:
    jump_single = false
    jump_double = true
  else:
    jump_double = false

func collect_coin():
  pass