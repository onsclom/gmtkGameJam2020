extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0
var ascending = true
export var seconds = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ascending:
		time += delta * (1.0/seconds)
	else:
		time -= delta * (1.0/seconds)
		
	if time < 0: 
		ascending = true
	if time > 1:
		ascending = false

	
	$Sprite.position = $start.position.linear_interpolate($end.position, time)
	
	pass
