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
				
				justPressed = false
		else:
			justPressed = true
