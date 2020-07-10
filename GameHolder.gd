extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rotationNode = $RotationNode
onready var labelNode = $Label

# Called when the node enters the scene tree for the first time.
var curRotationAmount = 0
var targetRotationAmount = 0
var timeToRotate = 2
var t = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("right_rotate"):
		targetRotationAmount += 90
		#rotationNode.set_rotation_degrees( targetRotationAmount )
		print("right")
		t = 0
	if Input.is_action_just_pressed("left_rotate"):
		targetRotationAmount -= 90
		print("left")
		t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if curRotationAmount != targetRotationAmount:
		labelNode.visible = true
		if curRotationAmount < targetRotationAmount:
			labelNode.text = "Rotating right"
			curRotationAmount += min(delta * 90 / timeToRotate, targetRotationAmount-curRotationAmount)
		else:
			labelNode.text = "Rotating left"
			curRotationAmount -= min(delta * 90 / timeToRotate, curRotationAmount-targetRotationAmount)
	else:
		labelNode.visible = false
	rotationNode.set_rotation_degrees( curRotationAmount )
	
	pass
