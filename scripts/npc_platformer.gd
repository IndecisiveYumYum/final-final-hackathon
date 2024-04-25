extends Area2D

var starting_x
var starting_y
var limit = 10
var direction = 1

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_x = self.position.x
	starting_y = self.position.y
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.position.x += 0.5 * direction
	
	if self.position.x < starting_x - limit:
		direction = 1
		sprite.frame = 10
		
	elif self.position.x > starting_x + limit:
		direction = -1
		sprite.frame = 6
		

func _on_body_entered(body):
	Global.flower_count -= 1
