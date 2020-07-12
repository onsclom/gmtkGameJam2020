extends Node

var gameHolder
var badScene = preload("res://BadEnd.tscn")
var mainScene = preload("res://MainScene.tscn")
var goodScene = preload("res://GoodEnd.tscn")

var timeRemaining = 999
var deaths = 245

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
