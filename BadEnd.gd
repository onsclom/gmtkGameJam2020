extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func change_scene(scene, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	#animation play fade
	get_tree().change_scene_to(scene)
	


# Called when the node enters the scene tree for the first time.
func _ready():
	play("startup")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if get_node("../Label") != null and get_node("../Label").text == "":
		get_node("../Label").text = "time remaining: " + str(GameManager.timeRemaining) + "\ndeaths: " + str(GameManager.deaths) + ""
	
	if Input.is_action_just_pressed("restart"):
		change_scene(GameManager.mainScene)
	
	if animation == "idle":
		if get_node("../Label") != null:
			get_node("../Label").visible = true
			
	
	pass


func _on_AnimatedSprite_animation_finished():
	if animation == "startup":
		play("idle")
