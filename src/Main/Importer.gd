extends Node

const ASSETS_PATH = "res://assets/"


func import(file_name:String) -> Mesh:
	var file_path = ASSETS_PATH + file_name
	var file := File.new()
	file.open(file_path, File.READ)
	
	var file_format : String = file_name.right(file_name.find_last(".")+1)
	
	match file_format:
		"obj":
			return _mesh_from_obj(file)
	
	push_error("Importer cannot import format " + file_format)
	return null


func _mesh_from_obj(file:File) -> Mesh:
	var model_data = $ObjImporter.import_as_obj(file)
	return create_mesh(model_data)


func create_mesh(model_data:ModelData) -> Mesh:
	var mesh := Mesh.new()
	var mat := SpatialMaterial.new()
	var st := SurfaceTool.new()
	
	mat.albedo_color = Color(0.9, 0.1, 0.1, .6)
	
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(mat)
	
	for f in model_data.faces:
		var vi = f[0] - 1
		var ui = f[1] - 1
		var ni = f[2] - 1
		
		st.add_normal(model_data.normals[ni])
		
		if ui >= 0:
			st.add_uv(model_data.uvs[ui])
			
		st.add_vertex(-model_data.vertices[vi])
	
	st.commit(mesh)
	
	return mesh

