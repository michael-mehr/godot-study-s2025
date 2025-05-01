extends CharacterBody3D

enum States { IDLE, RUNNING, ATTACKING }

var state: States = States.IDLE
var state_functions = {}

signal coin_collected

@export_subgroup("Components")
@export var view: Node3D

@export_subgroup("Properties")
@export var movement_speed = 500
@export var jump_strength = 15

var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0

var previously_floored = false

var jump_single = true
var coins: int = 0

@onready var model: Node3D = $Knight
@onready var animation = $Knight/AnimationPlayer
@onready var attack_timer: Timer = $AttackTimer
@onready var light_attack_area: Area3D = $LightAttackArea
@onready var l_attack_collision: CollisionShape3D = $LightAttackArea/CollisionShape3D

func _ready():
	# Initialize state functions
	state_functions[States.IDLE] = state_idle
	state_functions[States.RUNNING] = state_running
	state_functions[States.ATTACKING] = state_attacking

func _physics_process(delta):
	handle_gravity(delta)
	# handle_effects(delta)

	# Call the current state's function
	if state in state_functions:
		state_functions[state].call(delta)

	# General movement and rotation logic
	var applied_velocity: Vector3 = velocity.lerp(movement_velocity, delta * 10)
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

	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)

	previously_floored = is_on_floor()
	
	# if Input.is_action_just_pressed("light_attack"):
	# 	set_state(States.ATTACKING)

func state_idle(delta):
	handle_controls(delta)
	if movement_velocity.length() > 0:
		set_state(States.RUNNING)
	elif animation.current_animation != "Idle":
		animation.play("Idle", 0.1)

func state_running(delta):
	handle_controls(delta)
	if movement_velocity.length() == 0:
		set_state(States.IDLE)
	elif animation.current_animation != "Running_A":
			animation.play("Running_A", 0.1)

func state_attacking(delta):
	handle_controls(delta)
	if animation.current_animation != "1H_Melee_Attack_Slice_Horizontal":
		animation.play("1H_Melee_Attack_Slice_Horizontal")
		attack_timer.start(animation.current_animation_length / animation.speed_scale)
	if light_attack_area.monitoring == false:
		light_attack_area.monitoring = true

func handle_controls(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")

	if input.length() > 1:
		input = input.normalized()

	movement_velocity = input * movement_speed * delta

	if Input.is_action_just_pressed("jump") and jump_single:
		jump()

	if Input.is_action_just_pressed("light_attack"):
		set_state(States.ATTACKING)

func handle_gravity(delta):
	gravity += 25 * delta
	if gravity > 0 and is_on_floor():
		jump_single = true
		gravity = 0

func handle_effects(delta):
	if is_on_floor():
		var horizontal_velocity: Vector2 = Vector2(velocity.x, velocity.z)
		var speed_factor: float = horizontal_velocity.length() / movement_speed / delta
		if speed_factor > 0.05:
			if animation.current_animation != "Running_A":
				animation.play("Running_A", 0.1)
		elif animation.current_animation != "Idle":
			animation.play("Idle", 0.1)

func set_state(new_state: States):
	state = new_state

func jump():
	gravity = -jump_strength
	model.scale = Vector3(0.5, 1.5, 0.5)
	jump_single = false

func collect_coin():
	coins += 1
	coin_collected.emit(coins)


func _on_attack_timer_timeout():
	set_state(States.IDLE)
	light_attack_area.monitoring = false


func _on_light_attack_area_body_entered(body):
	if body.get_parent().name == "Enemies":
		body.queue_free()
