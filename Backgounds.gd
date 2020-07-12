extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var full = 416

var time = 20
var curTime = 0
# Called when the node enters the scene tree for the first time.


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curTime += delta
	if curTime >= time:
		curTime -= time
	$first.position.x = curTime/time * 416
	$second.position.x = $first.position.x - 416
	pass
	
	if get_node("../").time != 0:
		var size = (get_node("../").totalTime - get_node("../").time) / get_node("../").totalTime
		print(size)
		$AnimatedSprite.scale = Vector2(size,size)
		$CanvasModulate.color =  Color.from_hsv(38/255, size/4.0, 1.0)
	$AnimatedSprite.rotation += delta*10
