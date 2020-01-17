extends Node

onready var importer = $Importer
onready var spatial = $Spatial


func _ready() -> void:	
	var mesh = importer.import("cube.obj")
	spatial.create_mesh_instance(mesh)
