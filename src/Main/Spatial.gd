extends Spatial


func create_mesh_instance(array_mesh:Mesh) -> void:
	$MeshInstance.set_deferred("mesh", array_mesh)
