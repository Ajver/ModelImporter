extends Node


func import_as_obj(file:File) -> ModelData:
	var vertices := PoolVector3Array()
	var uvs := PoolVector2Array()
	var normals := PoolVector3Array()
	var faces := PoolVector3Array()
	
	while not file.eof_reached():
		var line : String = file.get_line()
		var first_line_char = line.left(2)
		
		match first_line_char:
			'v ':
				vertices.append(_line_to_vec3(line, "v ", " ", "float"))
				
			'vt':
#				uvs.append(_line_to_vec3(line, "vt", " ", "float"))
				var vars = line.trim_prefix("vt")
				
				var vars_arr = []
				for v in vars.split(" "):
					vars_arr.push_back(v.to_float())
				
				var vec2 = Vector2(
					vars_arr[0],
					vars_arr[1]
				)
				uvs.append(vec2)
				
			'vn':
				normals.append(_line_to_vec3(line, "vn", " ", "float"))
				
			'f ':
				var vars = line.trim_prefix("f ")
				
				for gr in vars.split(" "):
					faces.append(_line_to_vec3(gr, "", "/", "int"))
	
	var model_data = ModelData.new()
	model_data.vertices = vertices
	model_data.uvs = uvs
	model_data.normals = normals
	model_data.faces = faces
	
	return model_data

func _line_to_vec3(line:String, prefix:String, separator:String, type:String) -> Vector3:
	var vars : String = line.trim_prefix(prefix)
	var vars_arr = []
	
	for v in vars.split(separator):
		match type:
			"float":
				vars_arr.push_back(v.to_float())
			"int":
				vars_arr.push_back(v.to_int())
	
	return Vector3(
		vars_arr[0],
		vars_arr[1],
		vars_arr[2]
	)
