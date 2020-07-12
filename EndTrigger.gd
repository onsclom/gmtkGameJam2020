extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func change_scene(scene, delay = 0):
	yield(get_tree().create_timer(delay), "timeout")
	#animation play fade
	get_tree().change_scene_to(scene)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	
	if body.name == "KinematicBody2D":
		change_scene(GameManager.goodScene)
		pass
		
	pass # Replace with function body.
