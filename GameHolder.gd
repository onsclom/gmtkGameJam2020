extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rotationNode = $RotationNode

# Called when the node enters the scene tree for the first time.
var curRotationAmount = 0
var targetRotationAmount = 0
var timeToRotate = 1.5
var t = 0
var rotationResetCount = 0

var totalTime = 253

var time = 0
var started = false

onready var player = $RotationNode/KinematicBody2D
var playerTscn = preload("res://KinematicBody2D.tscn")
var badEnd = preload("res://BadEnd.tscn")


var startLevel = 0
var levels = [preload("res://TutorialLevel.tscn"), preload("res://Level1.tscn"), preload("res://Level1_5.tscn"), preload("res://Level2.tscn"), preload("res://Level2_5.tscn"), preload("res://Level3.tscn"), preload("res://FinalLevel.tscn")]

var badendTscn = 0

func change_scene(scene, delay = 0):
	yield(get_tree().create_timer(delay), "timeout")
	#animation play fade
	get_tree().change_scene_to(scene)

func _ready():
	GameManager.gameHolder = self
	changeMap(startLevel)
	pass # Replace with function body.

func _process(delta):
	
	#debug stuff
	if Input.is_action_just_pressed("right_rotate"):
		rotate(1)
	if Input.is_action_just_pressed("left_rotate"):
		rotate(-1)
		
	if started: 
		time -= delta
	$CanvasLayer/time.text = str(ceil(time))
	
	if time < 0:
		change_scene(GameManager.badScene)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if curRotationAmount != targetRotationAmount:
		if curRotationAmount < targetRotationAmount:
			curRotationAmount += min(delta * 90 / timeToRotate, targetRotationAmount-curRotationAmount)
		else:
			curRotationAmount -= min(delta * 90 / timeToRotate, curRotationAmount-targetRotationAmount)
	$RotationNode.set_rotation_degrees( curRotationAmount )
	
	pass
	
func playerDeath():
	print("gameholder got death!")
	player.queue_free()
	
	var newPlayer = playerTscn.instance()
	#must get rid of old player name
	player.name = "oldPlayer"
	newPlayer.name = "KinematicBody2D"
	player = newPlayer
	$RotationNode.add_child(newPlayer)
	newPlayer.position = $RotationNode/Spawn.position
	
	$CanvasLayer/Flash.flash()
	
	pass
	
func changeMap(mapNum):
	
	if mapNum != 0:
		$goal.playing=true
	
	if $RotationNode != null:
		$RotationNode.name = "oldMap"
		$oldMap.queue_free()
		
	var newMap = levels[mapNum].instance()
	add_child(newMap)
	newMap.name = "RotationNode"
	
	targetRotationAmount = 0
	curRotationAmount = 0
	
	if mapNum == 1:
		#then its level 1! start the timer!
		started = true
		time = totalTime
	if mapNum == len(levels)-1:
		started = false
	
	resetRotations()
	
func changeScene(sceneTscn):
	pass
	
func resetRotations():
	$CanvasLayer/AnimatedSprite.visible = false
	rotationResetCount += 1
	for child in $RotationNode/Rotations.get_children():
		child.triggered = false
	targetRotationAmount = 0
	curRotationAmount = 0
	
func rotate(dir):
	if dir == 1:
		$CanvasLayer/AnimatedSprite.play("right")
		$clockwise.playing = true
	elif dir == -1:
		$CanvasLayer/AnimatedSprite.play("left")
		$counter.playing = true
		
	var oldResetcount = rotationResetCount
		
	$CanvasLayer/AnimatedSprite.visible = true
	
	yield(get_tree().create_timer(2), "timeout")
	
	$CanvasLayer/AnimatedSprite.visible = false
	
	if oldResetcount == rotationResetCount:
		targetRotationAmount += dir*90
		t = 0
		
