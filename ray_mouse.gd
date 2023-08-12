extends MeshInstance3D

var from = Vector3(0.0, 0.0, 0.0)
var to = Vector3(0.0, 0.0, 0.0)
var justPressed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	from = $"../../MainCamera/XROrigin3D/XRController3DRight".global_position
	to = $"../../MainCamera/XROrigin3D/XRController3DRight/rayCastTo".global_position
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	if result and result.collider == $"..":
		var x = ((result.position.x / 5.76) + 0.5) * 1024
		var y = ((-(result.position.y / 3.24)) + 0.5) * 1024
		Input.warp_mouse(Vector2(x, y))
		$"../../DEBUGCUBE".position = result.position
		if $"../../MainCamera/XROrigin3D/XRController3DRight".is_button_pressed("trigger_click"):
			if justPressed:
				var event = InputEventMouseButton.new()
				event.position = Vector2(x, y)
				event.set_button_index(MOUSE_BUTTON_LEFT)
				event.set_pressed(true)
				event.set_button_mask(MOUSE_BUTTON_LEFT)
				Input.parse_input_event(event)
				
				event = InputEventMouseButton.new()
				event.position = Vector2(x, y)
				event.set_button_index(MOUSE_BUTTON_LEFT)
				event.set_pressed(false)
				event.set_button_mask(0)
				Input.parse_input_event(event)
				
				justPressed = false
		else:
			justPressed = true

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print(event)
