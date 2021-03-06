extends KinematicBody2D
 
const MOVE_SPEED = 75
const JUMP_FORCE = 1000/5
const GRAVITY = 50/5
const MAX_FALL_SPEED = 1000/5
const MAX_SLIDE_SPEED = 1000/20

var last_walljump = 10.0
var walljump_dir = 0

var walljump_push_time = .15

var secondJump = true

 
onready var sprite = $Sprite
 
var y_velo = 0
var facing_right = false
var last_y_velo = 0

func _ready():
	#this allows for playtesting levels not in gameholder
	if GameManager.gameHolder != null: 
		GameManager.gameHolder.player = self
 
func _physics_process(delta):
	
	last_walljump += delta
	
	var move_dir = 0
	if last_walljump > walljump_push_time:
		if Input.is_action_pressed("move_right"):
			move_dir += 1
		if Input.is_action_pressed("move_left"):
			move_dir -= 1
	else:
		move_dir = walljump_dir

	var grounded = is_on_floor()
	y_velo += GRAVITY
	
	if (grounded and last_y_velo > 50):
		$AnimatedSprite.play("landing")
	
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
		$jumpSound.playing = true
	elif Input.is_action_just_pressed("jump"):
		possiblyWallJump(move_dir)
	elif grounded:
		#if grounded and not jumping, then restore double jump!
		secondJump = true
		
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	if $left.is_colliding() and move_dir == -1:
		$AnimatedSprite.play("wall_cling")
		if y_velo > MAX_SLIDE_SPEED:
			y_velo = MAX_SLIDE_SPEED
	elif $right.is_colliding() and move_dir == 1:
		$AnimatedSprite.play("wall_cling")
		if y_velo > MAX_SLIDE_SPEED:
			y_velo = MAX_SLIDE_SPEED
	
	if !grounded and ! (($right.is_colliding() and move_dir == 1) or ($left.is_colliding() and move_dir == -1)):
		if y_velo > 25:
			$AnimatedSprite.play("downward_vel")
		elif abs(y_velo) < 25:
			$AnimatedSprite.play("0_vel")
		else:
			$AnimatedSprite.play("upward_vel")
		

		
	if Input.is_action_just_released("jump") and y_velo < 0:
		y_velo = y_velo/2
		
	last_y_velo = y_velo
		
	var possibleY = move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1)).y
	if possibleY >= 0:
		y_velo = possibleY
		
	rotation = -get_parent().rotation
	
	if ($AnimatedSprite.animation != "landing"):
		if grounded and move_dir==0:
			$AnimatedSprite.play("default")
		elif grounded and move_dir != 0:
			$AnimatedSprite.play("walk_run")
		
		
	if move_dir != 0:
		if move_dir == -1:
			if $AnimatedSprite.flip_h != true:
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		elif move_dir == 1:
			if $AnimatedSprite.flip_h != false:
				$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		if $AnimatedSprite.animation == "wall_cling":
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

#if holding direction of ray cast, then jump
func possiblyWallJump(move_dir):
	if $left.is_colliding():
		y_velo = -JUMP_FORCE
		$jumpSound.playing = true
		walljump_dir = 1
		last_walljump = 0
		secondJump = true
	elif $right.is_colliding():
		y_velo = -JUMP_FORCE
		$jumpSound.playing = true
		walljump_dir = -1
		last_walljump = 0
		secondJump = true
	else:
		#DOUBLE JUMP
		if secondJump == true:
			y_velo = -JUMP_FORCE
			$jumpSound.playing = true
			secondJump = false 
		
	


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "landing":
		$AnimatedSprite.play("default")
	pass # Replace with function body.
