extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var show = false

var targetTrans = 0
var curTrans = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if show: 
		targetTrans = 1
		curTrans = 1
	else:
		targetTrans = 0
		curTrans = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if curTrans < targetTrans:
		curTrans += delta
	else:
		curTrans -= delta
		
	if curTrans != 0 and is_inside_tree():
		modulate.a = curTrans
	
	pass

func _on_Area2D_body_entered(body):
	
	if body.name == "KinematicBody2D":
		targetTrans = 1
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.name == "KinematicBody2D":
		targetTrans = 0
	pass # Replace with function body.
