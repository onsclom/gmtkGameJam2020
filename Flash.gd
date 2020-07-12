extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func flash():
	
	modulate.a = 1
	frame = 0
	play("flash")
		
	pass


func _on_Flash_animation_finished():
	modulate.a = 0
	pass # Replace with function body.
