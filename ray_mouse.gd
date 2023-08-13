extends MeshInstance3D

var from = Vector3(0.0, 0.0, 0.0)
var to = Vector3(0.0, 0.0, 0.0)
var justPressed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# All this is badly hardcoded, don't learn from it haha :)
	from = $"../../MainCamera/XROrigin3D/XRController3DRight".global_position
	to = $"../../MainCamera/XROrigin3D/XRController3DRight/rayCastTo".global_position
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	if result and result.collider == $"..":
		var x = ((result.position.x / 5.76) + 0.5) * 1024
		var y = ((-(result.position.y / 3.24)) + 0.5) * 1024
		$"../../Pointer".global_position = result.position
		if $"../../MainCamera/XROrigin3D/XRController3DRight".is_button_pressed("trigger_click"):
			if justPressed:
				var node = $"../../SubViewportContainer/SubViewport".get_child(0)
				if node.name == "menu":
					if x > 302 and x < 721:
						if y > 595 and y < 683:
							node._on_play_pressed()
						elif y > 687 and y < 775:
							node._on_options_pressed()
						elif y > 779 and y < 867:
							node._on_quit_pressed()
				elif node.name == "hud":
					if x > 767 and y < 110:
						node._on_pause_pressed()
				elif node.name == "pause":
					if x > 314 and x < 710:
						if y > 603 and y < 691:
							node._on_resume_pressed()
						elif y > 695 and y < 783:
							node._on_menu_pressed()
				elif node.name == "game_over":
					if x > 370 and x < 653:
						if y > 678 and y < 766:
							node._on_play_pressed()
						elif y > 770 and y < 858:
							node._on_menu_pressed()
				elif node.name == "options":
					if x > 170 and x < 854:
						if y > 146 and y < 234:
							node._on_post_effects_pressed()
						elif y > 238 and y < 326:
							node._on_audio_pressed()
						elif y > 330 and y < 418:
							node._on_difficulty_pressed()
						elif y > 422 and y < 510:
							node._on_reset_score_pressed()
						elif y > 514 and y < 602:
							node._on_tutorial_pressed()
						elif y > 606 and y < 694:
							node._on_stats_pressed()
						elif y > 698 and y < 786:
							node._on_credits_pressed()
						elif y > 790 and y < 878:
							node._on_back_pressed()
				elif node.name == "tutorial":
					if x > 406 and x < 689:
						if y > 756 and y < 844:
							node._on_close_pressed()
						elif y > 848 and y < 936:
							node._on_menu_pressed()
				elif node.name == "Stats":
					if x > 370 and x < 653 and y > 785 and y < 973:
						node._on_menu_pressed()
				elif node.name == "credits":
					if x > 434 and x < 590 and y > 665 and y < 702:
						node._on_licences_pressed()
					elif x > 383 and x < 640 and y > 821 and y < 909:
						node._on_back_pressed()
				elif node.name == "licences":
					if y > 512:
						if x > 162 and x < 445:
							node._on_back_pressed()
						elif x > 611 and x < 912:
							node._on_next_pressed()
				
				justPressed = false
		else:
			justPressed = true
