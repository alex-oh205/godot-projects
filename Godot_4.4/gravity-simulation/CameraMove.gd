extends Node3D

var move_speed = 10
var mouse_sens = 0.2
var camera_anglev = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var joystick_forward = int(Input.is_action_pressed("forward")) - int(Input.is_action_pressed("backward"))
	var joystick_up = int(Input.is_action_pressed("up")) - int(Input.is_action_pressed("down"))
	var joystick_strafe = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	position += (-joystick_forward * global_basis.z.normalized()
				+ joystick_up * Vector3.UP
				+ joystick_strafe * global_basis.x.normalized()) * move_speed * delta

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		var changev = -event.relative.y * mouse_sens
		if camera_anglev + changev > -90 and camera_anglev + changev < 90:
			camera_anglev += changev
			$Camera3D.rotate_x(deg_to_rad(changev))
	elif event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
