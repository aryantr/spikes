extends Node2D

var spike_sprite = preload("res://sprites/spike.png")
var delta_vector : Vector2 = Vector2(45.18,8)
var position_x = 88

func _ready():
	
#	var spike = load("res://scenes/spike_scenes/4.tscn").instance()
#	spike.position = Vector2(8,208)
#
#	add_child(spike)
#	spike.add_to_group('spikes')
	_add_pickable()


func _add_pickable():
	randomize()
	var pick = load("res://scenes/pickable.tscn").instance()
	position_x = 88 if position_x==392 else 392
	var position_y = rand_range(160.00,696.00)
	pick.position = Vector2(position_x,position_y)
	call_deferred("add_child",pick)
	pick.connect("body_entered",self,"_on_picked_up",[pick])


func _on_picked_up(body, pick):
	print("Collected",body.name)
	if pick.is_connected("body_entered",self,"_on_picked_up"):
		pick.disconnect("body_entered",self,"_on_picked_up")
		print("disconnected")
	pick.queue_free()
	call_deferred("_add_pickable")

