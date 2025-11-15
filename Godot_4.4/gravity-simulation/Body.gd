class_name Body extends RigidBody3D

@export var initial_velocity := Vector3(0, 0, 0)

class Other:
	var m: float
	var pos: Vector3
	
	func _init(other_mass: float, other_pos: Vector3) -> void:
		m = other_mass
		pos = other_pos

var other_bodies: Dictionary[int, Other] = {}

func _ready() -> void:
	linear_velocity = initial_velocity

func _physics_process(delta: float) -> void:
	for body in other_bodies.values():
		var r: Vector3 = body.pos - global_position
		var force: Vector3 = global.G * body.m * mass / r.length() ** 2 * r.normalized()
		apply_central_force(force)

func update_other_bodies(id: int, pos: Vector3, m: float) -> void:
	other_bodies[id] = Other.new(m, pos)
