extends CharacterBody2D

@onready var animation = $AnimationPlayer


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const DASH_SPEED = 400.0

var jump_count = 0
var max_jumps = 3

var dashing = false
var can_dash = true
var s_dashing = false
var s_can_dash = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Shield.visible = false
	$Sword.visible = false
	$Bow.visible = false

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animation.play("jump")

	if is_on_floor():
		jump_count = 0

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	if Input.is_action_just_pressed("Dash") and can_dash:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_again_timer.start()

		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:	
		if dashing:
			velocity.x = direction * DASH_SPEED
			velocity.y = 0
		
		elif s_dashing:
			velocity.x = direction * DASH_SPEED * 4
			velocity.y = 0
		
		else:
			velocity.x = direction * SPEED
			
			
		
		print(direction)
		if direction > 0:
			$Shield.position.x = 11
			animation.play("walk_right")
		else: 
			$Shield.position.x = -11
			animation.play("walk_left")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("Sprint"):
		velocity.x = direction * SPEED * 1.5

	move_and_slide()
	
	if self.position.y > 1000:
		get_tree().quit()


	if Input.is_action_pressed("W1"):
		$Shield.visible = true
		$Sword.visible = false
		$Bow.visible = false
		
		Global.bow = false
		max_jumps = 2
			
		
	if Input.is_action_pressed("W2"):
		$Shield.visible = false
		$Sword.visible = true
		$Bow.visible = false
		
		Global.bow = false
		max_jumps = 2
		
	if Input.is_action_pressed("W3"):
		$Shield.visible = false
		$Sword.visible = false
		$Bow.visible = true
		
		Global.bow = true
		max_jumps = 2
		
	if Input.is_action_pressed("W4"):
		$Shield.visible = false
		$Sword.visible = false
		$Bow.visible = false
		
		Global.bow = false
		max_jumps = 3
		
		
	if $Shield.visible == true:
		if Input.is_action_just_pressed("RMouse") and s_can_dash:
			print("potato")
			s_dashing = true
			s_can_dash = false
			$shield_timer.start()
			$shield_again_timer.start()
			
	if $Bow.visible == true or $Sword.visible == true:
		
		look_at(get_global_mouse_position())
		
	
func _on_dash_timer_timeout():
	dashing = false


func _on_dash_again_timer_timeout():
	can_dash = true
	
func _on_shield_timer_timeout():
	s_dashing = false

func _on_shield_again_timer_timeout():
	s_can_dash = true
	

func _on_chain_hooked(hooked_position):
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", hooked_position, 0.75)
	velocity.y = 0

		



func _on_rope_hooked(hooked_position):
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", hooked_position, 0.75)


