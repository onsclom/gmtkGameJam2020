extends Area2D

var triggered = false
export var dir = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "KinematicBody2D" and triggered == false:
		triggered = true
		GameManager.gameHolder.rotate(dir)
