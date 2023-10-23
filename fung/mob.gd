extends RigidBody2D

var speed = 750
var velocity = Vector2()

func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _integrate_forces(state):
	if state.linear_velocity.length()<300:
		state.linear_velocity=state.linear_velocity.normalized()*300
	
