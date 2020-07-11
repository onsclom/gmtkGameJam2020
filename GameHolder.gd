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

onready var player = $RotationNode/KinematicBody2D
var playerTscn = preload("res://KinematicBody2D.tscn")


var startLevel = 0
var levels = [preload("res://TutorialLevel.tscn"), preload("res://Level1.tscn"), preload("res://Level2.tscn"), preload("res://Level3.tscn"), preload("res://FinalLevel.tscn")]


func _ready():
	GameManager.gameHolder = self
	changeMap(startLevel)
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("right_rotate"):
		rotate(1)
	if Input.is_action_just_pressed("left_rotate"):
		rotate(-1)

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
	player.name = "a"
	newPlayer.name = "KinematicBody2D"
	player = newPlayer
	$RotationNode.add_child(newPlayer)
	newPlayer.position = $RotationNode/Spawn.position
	
	pass
	
func changeMap(mapNum):
	if $RotationNode != null:
		$RotationNode.name = "oldMap"
		$oldMap.queue_free()
		
	var newMap = levels[mapNum].instance()
	add_child(newMap)
	newMap.name = "RotationNode"
	
	targetRotationAmount = 0
	curRotationAmount = 0
	
	resetRotations()
	
func resetRotations():
	for child in $RotationNode/Rotations.get_children():
		child.triggered = false
	targetRotationAmount = 0
	curRotationAmount = 0
	
func rotate(dir):
	if dir == 1:
		$CanvasLayer/Label.text = "Right Rotate!"
	elif dir == -1:
		$CanvasLayer/Label.text = "Left Rotate!"
		
	$CanvasLayer/Label.visible = true
	
	yield(get_tree().create_timer(2), "timeout")
	
	$CanvasLayer/Label.visible = false
	
	targetRotationAmount += dir*90
	t = 0
		
