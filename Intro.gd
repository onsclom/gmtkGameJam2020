extends AnimatedSprite

var animations = ["Startup0", "Idle0", "Startup1", "Idle1", 
"Startup2", "Idle2", "Startup3", "Idle3", 
"Startup4", "Idle4", "Startup5"]

var cur = 0

var time = 0

func change_scene(scene, delay = 0.0):
	yield(get_tree().create_timer(delay), "timeout")
	#animation play fade
	get_tree().change_scene_to(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	play(animations[0])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	if cur % 2 == 1 and time>3:
		get_node("../mouse").visible = true
	else:
		get_node("../mouse").visible = false
		
	
	if Input.is_action_just_pressed("click"):
		print("yay")
		cur += 1
		play(animations[cur])
		time = 0


func _on_AnimatedSprite_animation_finished():
	if cur == 10:
		change_scene(GameManager.mainScene)
	elif cur % 2 == 0:
		cur += 1
		play(animations[cur])
		time = 0
