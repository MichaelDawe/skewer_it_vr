extends MeshInstance3D

var from = Vector3(0.0, 0.0, 0.0)
var to = Vector3(0.0, 0.0, 0.0)
var justPressed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func isInQ(p, pos, size):
	if p.x > pos.x and p.x < pos.x + size.x and p.y > pos.y and p.y < pos.y + size.y:
		return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	from = $"../../MainCamera/XROrigin3D/XRController3DRight".global_position
	to = $"../../MainCamera/XROrigin3D/XRController3DRight/rayCastTo".global_position
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	if result and result.collider == $"..":
		var x = ((result.position.x / 5.76) + 0.5) * 1920
		var y = ((-(result.position.y / 3.24)) + 0.5) * 1080
		$"../../Pointer".global_position = result.position
		if $"../../MainCamera/XROrigin3D/XRController3DRight".is_button_pressed("trigger_click"):
			if justPressed:
				var node = $"../../SubViewportContainer/SubViewport".get_child(0)
				var item
				var pos = Vector2(x, y)
				if node.name == "menu":
					item = node.get_node("VBoxContainer/Play")
					if isInQ(pos, item.position, item.size):
						node._on_play_pressed()
					else:
						item = node.get_node("VBoxContainer/Options")
						if isInQ(pos, item.position, item.size):
							node._on_options_pressed()
						else:
							item = node.get_node("VBoxContainer/Quit")
							if isInQ(pos, item.position, item.size):
								node._on_quit_pressed()
				elif node.name == "hud":
					item = node.get_node("MarginContainer/Pause")
					if isInQ(pos, item.position, item.size):
						node._on_pause_pressed()
				elif node.name == "pause":
					item = node.get_node("VBoxContainer/Resume")
					if isInQ(pos, item.position, item.size):
						node._on_resume_pressed()
					else:
						item = node.get_node("VBoxContainer/Menu")
						if isInQ(pos, item.position, item.size):
							node._on_menu_pressed()
				elif node.name == "game_over":
					item = node.get_node("VBoxContainer/Play")
					if isInQ(pos, item.position, item.size):
						node._on_play_pressed()
					else:
						item = node.get_node("VBoxContainer/Menu")
						if isInQ(pos, item.position, item.size):
							node._on_menu_pressed()
				elif node.name == "options":
					item = node.get_node("VBoxContainer/PostEffects")
					if isInQ(pos, item.position, item.size):
						node._on_post_effects_pressed()
					else:
						item = node.get_node("VBoxContainer/Audio")
						if isInQ(pos, item.position, item.size):
							node._on_audio_pressed()
						else:
							item = node.get_node("VBoxContainer/Difficulty")
							if isInQ(pos, item.position, item.size):
								node._on_difficulty_pressed()
							else:
								item = node.get_node("VBoxContainer/Reset Score")
								if isInQ(pos, item.position, item.size):
									node._on_reset_score_pressed()
								else:
									item = node.get_node("VBoxContainer/Tutorial")
									if isInQ(pos, item.position, item.size):
										node._on_tutorial_pressed()
									else:
										item = node.get_node("VBoxContainer/Stats")
										if isInQ(pos, item.position, item.size):
											node._on_stats_pressed()
										else:
											item = node.get_node("VBoxContainer/Credits")
											if isInQ(pos, item.position, item.size):
												node._on_credits_pressed()
											else:
												item = node.get_node("VBoxContainer/Back")
												if isInQ(pos, item.position, item.size):
													node._on_back_pressed()
				elif node.name == "tutorial":
					item = node.get_node("VBoxContainer/Play")
					if isInQ(pos, item.position, item.size):
						node._on_close_pressed()
					else:
						item = node.get_node("VBoxContainer/Menu")
						if isInQ(pos, item.position, item.size):
							node._on_menu_pressed()
				elif node.name == "Stats":
					item = node.get_node("VBoxContainer/Menu")
					if isInQ(pos, item.position, item.size):
						node._on_menu_pressed()
				elif node.name == "credits":
					item = node.get_node("VBoxContainer/Licences")
					if isInQ(pos, item.position, item.size):
						node._on_licences_pressed()
					else:
						item = node.get_node("VBoxContainer/Back")
						if isInQ(pos, item.position, item.size):
							node._on_back_pressed()
				elif node.name == "licences":
					item = node.get_node("VBoxContainer/HBoxContainer/Back")
					if isInQ(pos, item.global_position, item.size):
						node._on_back_pressed()
					else:
						item = node.get_node("VBoxContainer/HBoxContainer/NEXT")
						if isInQ(pos, item.global_position, item.size):
							node._on_next_pressed()
				
				justPressed = false
		else:
			justPressed = true
	else:
		$"../../Pointer".position.z = 9999
