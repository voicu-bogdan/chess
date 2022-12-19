extends Node

export var mainGameScene : PackedScene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_Button_button_up():
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Exit_Button_button_down():
	get_tree().quit()
