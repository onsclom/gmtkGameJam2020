extends Node2D

func change_scene(scene, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	#animation play fade
	get_tree().change_scene_to(scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		change_scene(GameManager.mainScene)
