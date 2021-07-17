extends Node

var spike_sprite = preload("res://sprites/spike.png")
var delta_vector : Vector2 = Vector2(45.18,8)
var is_loaded : bool

func _ready():
	for i in range(6):
		_add_parent_spike((i*2)+2)

func _add_parent_spike(count):
	var parent = StaticBody2D.new()
	var tween = Tween.new()
	tween.name = 'tween'
	_add_spikes(count,parent)
	_add_collider_spikes(count,parent)
	parent.add_child(tween)
	tween.set_owner(parent)
	
	var pack_scene = PackedScene.new()
	var pack_location : String = "res://scenes/spike_scenes/" + str(count) + ".tscn"
	pack_scene.pack(parent)
	
	if(ResourceSaver.save(pack_location,pack_scene) == OK):
		print("Pack Scene created for spike "+str(count))
		is_loaded = true
	else:
		print("Not Found")


func _add_spikes(count : int,parent_node : StaticBody2D):
	if(count<1):
		return
	for i in range(count):
		var sprite = load("res://scenes/spike.tscn").instance()
		sprite.position = Vector2(24,(8 * ((2*i) +1)) )
		parent_node.add_child(sprite)
		sprite.set_owner(parent_node)
	return

func _add_collider_spikes(count: int,parent_node: StaticBody2D):
	if(count>1):
		var collider_array : Array = []
		collider_array.append(Vector2.ZERO)
		collider_array.append(delta_vector)
		collider_array.append(Vector2(delta_vector.x,((count-1)*2*delta_vector.y)+8))
		collider_array.append(Vector2(0,count*2*delta_vector.y))
		
		var collider = CollisionPolygon2D.new()
		collider.set_polygon(PoolVector2Array(collider_array))
		parent_node.add_child(collider)
		collider.set_owner(parent_node)
		return

func _add_tween():
	var tween = Tween.new()
	
