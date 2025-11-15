extends Node3D

var bodies: Array[Body] = []

func _ready() -> void:
	for child in get_children():
		if child is Body:
			bodies.append(child)

func _process(delta: float) -> void:
	for i in range(bodies.size()):
		for j in range(bodies.size()):
			if j != i:
				bodies[i].update_other_bodies(j, bodies[j].global_position, bodies[j].mass)
