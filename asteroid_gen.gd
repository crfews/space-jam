extends MeshInstance3D

@export var sphere_radius := 2.0
@export var noise_strength := 1.8
@export var noise_scale := 2.0
@export var sphere_radial_segments := 5
@export var sphere_rings := 5

var noise := FastNoiseLite.new()

func _ready():
	mesh = generate_asteroid()

func generate_asteroid() -> ArrayMesh:
	#var sphere := SphereMesh.new()
	#generate dodecahedron-based sphere for better performance with low poly count
	var sphere := SphereMesh.new()
	sphere.radial_segments = sphere_radial_segments
	sphere.rings = sphere_rings
	sphere.radius = sphere_radius

	var arrays: Array = sphere.get_mesh_arrays()
	var vertices: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]

	noise.seed = randi()
	noise.frequency = 1.0

	for i in range(vertices.size()):
		var v: Vector3 = vertices[i]
		var dir := v.normalized()
		var n := noise.get_noise_3d(
			dir.x * noise_scale,
			dir.y * noise_scale,
			dir.z * noise_scale
		)
		vertices[i] = dir * (sphere_radius + n * noise_strength)

	arrays[Mesh.ARRAY_VERTEX] = vertices

	var new_mesh := ArrayMesh.new()
	new_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return new_mesh
