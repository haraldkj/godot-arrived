extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	#$AnimatedSprite2D/PointLight2D.energy = randf_range(0,14)
	
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		#$AnimatedSprite2D/PointLight2D.set_blend_mode(1)
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		#$AnimatedSprite2D/PointLight2D.set_blend_mode(0)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body):
	var position = Vector2.ZERO
	position = body.global_position
	
	var direction = ( position - self.global_position ).normalized()
	#print(direction)
	body.apply_impulse(direction* 750)
	#body.linear_velocity = 100
	#body.hide()
	#hide() # Player disappears after being hit.
	#hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionShape2D.set_deferred("disabled", true)
