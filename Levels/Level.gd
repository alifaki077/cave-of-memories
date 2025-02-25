extends Node2D

var collected = 0
export var next_scene: PackedScene
var save_path = "user://save.txt"

func _ready() -> void:
	var data = {
		"last_scene": get_tree().current_scene.filename
	}
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	
	if error == OK:
		file.store_var(data)
		file.close()

func _on_Player_piece(id) -> void:
	get_node('UI/p' + id).visible = true
	collected += 1
	var collected_str = String(collected)
	get_node('UI/collected').text = 'Collected Pieces: ' + collected_str + '/9'
	if collected == 9:
		get_node('UI/next-level-hint').visible = true


func _on_NextLevelDoor_body_entered(body: Node) -> void:
	if collected < 9:
		get_node('UI/warn').visible = true
	else:
		get_tree().change_scene_to(next_scene)


func _on_NextLevelDoor_body_exited(body: Node) -> void:
	get_node('UI/warn').visible = false
