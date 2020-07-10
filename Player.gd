extends KinematicBody2D
 
const MOVE_SPEED = 75
const JUMP_FORCE = 1000/5
const GRAVITY = 50/5
const MAX_FALL_SPEED = 1000/5
 
onready var sprite = $Sprite
 
var y_velo = 0
var facing_right = false
 
func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
   
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
		
	rotation = -get_parent().rotation
