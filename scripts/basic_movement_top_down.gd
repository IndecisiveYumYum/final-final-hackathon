extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var flower_sprite = $Flower

const SPEED = 300.0

func _ready():
	flower_sprite.visible = false
	

func _physics_process(delta):
	
	if Global.flower_found == true:
		flower_sprite.visible = true
	else: 
		flower_sprite.visible = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1 * SPEED
		animation.play("walk_left")
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1 * SPEED
		animation.play("walk_right")
		
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -1 * SPEED
		animation.play("walk_up")
		
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1 * SPEED
		animation.play("walk_down")	
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
