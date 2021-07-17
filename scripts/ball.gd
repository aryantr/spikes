extends RigidBody2D

var direction = Vector2()

func _ready():
	direction = Vector2.LEFT

func _physics_process(_delta):
	if(Input.is_action_just_pressed("ui_up")):
		set_linear_velocity((Vector2.UP + direction)*400)

func collided_change_direction(body):
	if(body.is_in_group('walls')):
		direction = -(direction)
	elif(body.is_in_group('spikes')):
		print('Spikes collided')
