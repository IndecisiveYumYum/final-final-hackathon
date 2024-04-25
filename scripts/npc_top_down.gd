extends Area2D

@onready var dialogue_sprite: Sprite2D = get_node("Dialogue1")

func _ready():
	dialogue_sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		


func _on_body_entered(body):

	if Global.quest == false:
		if Global.npc_introduction == false:
			Global.npc_introduction = true
			dialogue_sprite.visible = true
			await get_tree().create_timer(1).timeout
			dialogue_sprite.visible = false
		elif Global.npc_introduction == true and Global.flower_found == false:
			dialogue_sprite.visible = true
			dialogue_sprite.texture = load("res://dialogue/npc/dialogue_2.png")
			await get_tree().create_timer(5).timeout
			dialogue_sprite.visible = false
		elif Global.npc_introduction == true and Global.flower_found == true:
			dialogue_sprite.visible = true
			dialogue_sprite.texture = load("res://dialogue/npc/dialogue_3.png")
			Global.flower_found = false
			await get_tree().create_timer(5).timeout
			dialogue_sprite.visible = false
			Global.quest = true
		
		
		

