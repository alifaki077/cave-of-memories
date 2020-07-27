extends KinematicBody2D

export var speed = 256
var v = Vector2(1, 0)
var velocity = Vector2.ZERO

func init(x: int, y: int) -> void:
	v.x = x
	v.y = y

func _physics_process(delta: float) -> void:
	velocity.x = v.x * speed
	velocity.y = v.y * speed
	var col = move_and_collide(velocity * delta)

	if col:
		queue_free()
	